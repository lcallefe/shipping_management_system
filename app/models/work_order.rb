class WorkOrder < ApplicationRecord
  has_one :expressa
  has_one :sedex_dez
  has_one :sedex
  has_one :vehicle
  validates :street, :city, :state, :number, :customer_name, :customer_cpf, presence: true
  validates :customer_phone_numer, :product_name,:product_weight, :sku, presence: true
  validates :warehouse_city, :warehouse_number,:warehouse_state, :warehouse_street, :distance, presence: true
  validates :customer_cpf, length: { is: 11 }
  validates :product_weight, :distance, numericality: { greater_than: 0 }
  validate :check_address
  validates :delay_reason, presence: true, if: :check_delay_reason?
  enum status: { pendente: 0, em_progresso: 1, encerrada_no_prazo: 3, encerrada_em_atraso: 4 }
  before_create :generate_code
  after_update :find_price_sedex

  def full_warehouse_address  
    "#{warehouse_street}, #{warehouse_number}, #{warehouse_city} - #{warehouse_state}"
  end  

  def full_customer_address  
    "#{street}, #{number}, #{city} - #{state}"
  end 
  
  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def check_address  
    if street == warehouse_street && number == warehouse_number && city == warehouse_city && state == warehouse_state
      errors.add(:street, " do cliente deve ser diferente do destinatário")
    end
  end 
  def check_delay_reason? 
    !self.id.nil? && !self.shipping_expected_date.nil? && Date.today > self.shipping_expected_date
  end
  def find_price_sedex
    if self.shipping_method = "Sedex"
      spd_price_distance = ActiveRecord::Base.connection.exec_query("select spd.price 
      from work_orders w join sedexes s
      on w.id = s.work_order_id join second_price_distances spd 
      on s.id = spd.sedex_id 
      where w.distance between spd.min_distance and spd.max_distance").rows.join.to_i

      spd_price_weight = ActiveRecord::Base.connection.exec_query("select spw.price 
      from work_orders w join sedexes s
      on w.id = s.work_order_id join second_price_weights spw 
      on s.id = spw.sedex_id 
      where w.product_weight between spw.min_weight and spw.max_weight").rows.join.to_i

      self.total_price = (self.distance * spd_price_weight) + spd_price_distance + Sedex.last.flat_fee
    end
  end


  
  
  
  
  def find_shipping_method_price_distance
    @work_order = WorkOrder.find(params[:id])
    expressa = ActiveRecord::Base.connection.exec_query(
      "select p.min_distance, p.max_distance, p.price, e.id 
      from expressas e 
      join third_price_distances p on e.id = p.expressa_id")

    sedex = ActiveRecord::Base.connection.exec_query(
      "select p.min_distance, p.max_distance, p.price, s.id 
      from sedexes s
      join second_price_distances p on s.id = p.sedex_id")

    sedex_dez = ActiveRecord::Base.connection.exec_query(
      "select p.min_distance, p.max_distance, p.price, sd.id 
      from sedex_dezs sd
      join first_price_distances p on sd.id = p.sedex_dez_id")

    expressa.rows.each do |row|
      temp = Expressa.find(row[3])
      if ((row[0]..row[1]).include? @work_order.distance) && (temp.ativo?)
        @price_distance_expressa = row[2]
        temp.update(work_order_id:@work_order.id)
      end
    end

    sedex.rows.each do |row|
      temp = Sedex.find(row[3])
      if ((row[0]..row[1]).include? @work_order.distance) && (temp.ativo?)
        @price_distance_sedex = row[2]
        temp.update(work_order_id:@work_order.id)
      end
    end

    sedex_dez.rows.each do |row|
      temp = SedexDez.find(row[3])
      if ((row[0]..row[1]).include? @work_order.distance) && (temp.ativo?)
        @price_distance_sd = row[2]
        SedexDez.find(row[3]).update(work_order_id:@work_order.id)
      end
    end
  end

  def find_shipping_method_price_weight
    @work_order = WorkOrder.find(params[:id])
    expressa = ActiveRecord::Base.connection.exec_query(
      "select p.min_weight, p.max_weight, p.price, e.id 
      from expressas e 
      join third_price_weights p on e.id = p.expressa_id")

    @sedex = ActiveRecord::Base.connection.exec_query(
      "select p.min_weight, p.max_weight, p.price, s.id 
      from sedexes s
      join second_price_weights p on s.id = p.sedex_id")

    sedex_dez = ActiveRecord::Base.connection.exec_query(
      "select p.min_weight, p.max_weight, p.price, sd.id 
      from sedex_dezs sd
      join first_price_weights p on sd.id = p.sedex_dez_id")

    expressa.rows.each do |row|
      temp = Expressa.find(row[3])
      if ((row[0]..row[1]).include? @work_order.product_weight) && (temp.ativo?)
        @price_weight_expressa = row[2]
        temp.update(work_order_id:@work_order.id)
      end
    end

    @sedex.rows.each do |row|
      temp = Sedex.find(row[3])
      if ((row[0]..row[1]).include? @work_order.product_weight) && (temp.ativo?)
        @price_weight_sedex = row[2]
        temp.update(work_order_id:@work_order.id)
      end
    end

    sedex_dez.rows.each do |row|
      temp = SedexDez.find(row[3])
      if ((row[0]..row[1]).include? @work_order.product_weight) && (temp.ativo?)
        @price_weight_sedex_dez = row[2]
        temp.update(work_order_id:@work_order.id)
      end
    end
  end

  def find_shipping_method_delivery_time
    expressa = ActiveRecord::Base.connection.exec_query(
      "select d.min_distance, d.max_distance, d.delivery_time, e.id 
      from expressas e 
      join third_delivery_time_distances d
      on e.id = d.expressa_id")

    sedex = ActiveRecord::Base.connection.exec_query(
      "select d.min_distance, d.max_distance, d.delivery_time, s.id
      from sedexes s
      join second_delivery_time_distances d
      on s.id = d.sedex_id")

    sedex_dez = ActiveRecord::Base.connection.exec_query(
      "select d.min_distance, d.max_distance, d.delivery_time, sd.id 
      from sedex_dezs sd
      join first_delivery_time_distances d
      on sd.id = d.sedex_dez_id")

    expressa.rows.each do |row|
      temp = Expressa.find(row[3])
      if ((row[0]..row[1]).include? @work_order.product_weight) && (temp.ativo?)
        @delivery_time_expressa = row[2]
        temp.update(work_order_id:@work_order.id)
      end
    end

    sedex.rows.each do |row|
      temp = Sedex.find(row[3])
      if ((row[0]..row[1]).include? @work_order.distance) && (temp.ativo?)
        @delivery_time_sedex = row[2]
        temp.update(work_order_id:@work_order.id)
      end
    end

    sedex_dez.rows.each do |row|
      temp = SedexDez.find(row[3])
      if ((row[0]..row[1]).include? @work_order.distance) && (temp.ativo?)
        @delivery_time_sedex_dez = row[2]
        temp.update(work_order_id:@work_order.id)
      end
    end
  end

  def calculate_fee
    @shipping_methods = []
    @work_order = WorkOrder.find(params[:id])
    find_shipping_method_price_weight
    find_shipping_method_price_distance
    find_shipping_method_delivery_time

    flat_fee_expressa = Expressa.find_by(work_order_id: @work_order.id).flat_fee if Expressa.find_by(work_order_id: @work_order.id)
    flat_fee_sedex = Sedex.find_by(work_order_id: @work_order.id).flat_fee if Sedex.find_by(work_order_id: @work_order.id)
    flat_fee_sedex_dez = SedexDez.find_by(work_order_id: @work_order.id).flat_fee if SedexDez.find_by(work_order_id: @work_order.id)
   

    if !@price_distance_expressa.nil? && !@price_weight_expressa.nil? && !flat_fee_expressa.nil? && !@delivery_time_expressa.nil?
      @fee_expressa = @price_distance_expressa + (@work_order.distance * @price_weight_expressa) + (flat_fee_expressa)
    end

    if !@price_distance_sedex.nil? && !@price_weight_sedex.nil? && !flat_fee_sedex.nil? && !@delivery_time_sedex.nil?
      @fee_sedex = @price_distance_sedex + (@work_order.distance * @price_weight_sedex) + (flat_fee_sedex)
    end
    
    if !@price_distance_sd.nil? && !@price_weight_sedex_dez.nil? && !flat_fee_sedex_dez.nil? && !@delivery_time_sedex_dez.nil?
      @fee_sedex_dez = @price_distance_sd + (@work_order.distance * @price_weight_sedex_dez) + (flat_fee_sedex_dez)
    end
   
    @shipping_methods << ['expressa', @fee_expressa] if @fee_expressa
    @shipping_methods << ['sedex', @fee_sedex] if @fee_sedex
    @shipping_methods << ['sedex_dez', @fee_sedex_dez] if @fee_sedex_dez
  end


  def work_order_create_params 
    work_order_create_params = params.require(:work_order).permit(:street, :city, :state, 
    :number, :customer_name, :customer_cpf, :customer_phone_numer, :product_name,
    :product_weight, :sku, :warehouse_street, :warehouse_state, :warehouse_number, 
    :distance, :warehouse_city)
  end

  def delay_reason_param
    delay_reason_param = params.require(:work_order).permit(:delay_reason)
  end

  def work_order_start_params
    work_order_start_params = params.require(:work_order).permit(:shipping_method)
  end

  def set_vehicle
    @work_order = WorkOrder.find(params[:id])
    @vehicle = Vehicle.joins(@work_order.shipping_method.downcase.parameterize(separator:'_').to_sym).where("full_capacity >= ?", @work_order.product_weight).and(Vehicle.where("vehicles.status == ?",1)).order('RANDOM()').first
    @vehicle.update(work_order_id:@work_order.id)
    return @vehicle
  end

end
