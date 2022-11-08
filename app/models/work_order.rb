class WorkOrder < ApplicationRecord
  has_one :shipping_method
  validates :street, :city, :state, :number, :customer_name, :customer_cpf, presence: true
  validates :customer_phone_numer, :product_name,:product_weight, :sku, presence: true
  validates :warehouse_city, :warehouse_number,:warehouse_state, :warehouse_street, :distance, presence: true
  validates :customer_cpf, length: { is: 11 }
  validates :product_weight, :distance, numericality: { greater_than: 0 }
  validate :check_address
  validates_uniqueness_of :code, on: :create
  enum status: { pending: 0, in_progress: 1, within_deadline: 3, after_deadline: 4 }
  before_create :generate_code

  def full_warehouse_address  
    "#{warehouse_street}, #{warehouse_number}, #{warehouse_city} - #{warehouse_state}"
  end  

  def full_customer_address  
    "#{street}, #{number}, #{city} - #{state}"
  end 

  def find_price
    @sm_and_prices = []
    ShippingMethod.update(work_order_id:self.id)
   
    find_available_shipping_methods.each do |sm| 
  
      price_distance = ActiveRecord::Base.connection.exec_query("select pd.price 
      from work_orders w join shipping_methods sm 
      on w.id = sm.work_order_id join price_distances pd 
      on sm.id = pd.shipping_method_id
      where w.distance between pd.min_distance and pd.max_distance and sm.status == 1").rows.join.to_i

      price_weight = ActiveRecord::Base.connection.exec_query("select pw.price 
      from work_orders w join shipping_methods sm
      on w.id = sm.work_order_id join price_weights pw 
      on sm.id = pw.shipping_method_id
      where w.product_weight between pw.min_weight and pw.max_weight and sm.status == 1").rows.join.to_i

      flat_fee = ActiveRecord::Base.connection.exec_query("select sm.flat_fee 
      from work_orders w join shipping_methods sm 
      on w.id = sm.work_order_id and sm.status == 1").rows.join.to_i
      
      if !price_weight.nil? && !price_weight.zero? && !price_distance.nil? && !price_distance.zero? && !flat_fee.nil? && !flat_fee.zero?
        sm_price = (self.distance * price_weight) + price_distance + flat_fee
      end
      if sm_price == nil then @sm_and_prices == nil else @sm_and_prices << [shipping_method, sm_price] end
    end

    return @sm_and_prices.to_h
  end

  def find_delivery_time
    @delivery_times = []
    ShippingMethod.update(work_order_id:self.id)

    find_available_shipping_methods.each do |shipping_method| 
      delivery_time = ActiveRecord::Base.connection.exec_query("select dt.delivery_time 
      from work_orders w join shipping_methods sm
      on w.id = sm.work_order_id join delivery_time_distances dt 
      on sm.id = dt.shipping_method_id 
      where w.distance between dt.min_distance and dt.max_distance and sm.status == 1").rows.join.to_i
      @delivery_times << [shipping_method, delivery_time]
    end

    return @delivery_times.to_h

  end

  def check_available_prices_and_delivery_times 
    new_hash_available_shipping_methods = []
    delivery_time = find_delivery_time 
    price = find_price

    if !delivery_time.empty? && !price.empty? 
      find_available_shipping_methods.each do |s|
        if (!price.include? s) || (!delivery_time.include? s) || (delivery_time[s].zero?) || (price[s].zero?)
          if (price.include? s) && (delivery_time.include? s) 
            price.delete(s) 
            delivery_time.delete(s)
          elsif delivery_time.include? s
            delivery_time.delete(s)
          elsif price.include? s  
            price.delete(s)
          end
        end
      end

      new_hash_available_shipping_methods << delivery_time.merge!(price){ |k, delivery_time, price| Array(delivery_time).push(price) }
    end

    if new_hash_available_shipping_methods[0].nil? 
      self.errors.add(:base, "Não há modalidades de entrega disponíveis.")
    end
    new_hash_available_shipping_methods[0]
  end

  def set_deadline_and_price
    price_and_delivery_time = check_available_prices_and_delivery_times.values[0]
    update_attribute(:departure_date, Date.today)
    update_attribute(:shipping_expected_date, Date.today + (price_and_delivery_time[0].to_f/24))
    update_attribute(:total_price, price_and_delivery_time[1])
  end

  def set_vehicle  
    @vehicle = Vehicle.joins(:shipping_method).where("full_capacity >= ?", self.product_weight).and(Vehicle.where("vehicles.status == ?",1)).order('RANDOM()').first
    if !@vehicle.nil?
      @vehicle.in_progress!
    else  
      self.errors.add(:base, "Não há veículos disponíveis para a modalidade escolhida.")
      return false
    end
    true
  end 
  
  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def find_available_shipping_methods 
    ShippingMethod.all
  end

  def check_address  
    if street == warehouse_street && number == warehouse_number && city == warehouse_city && state == warehouse_state
      errors.add(:street, " do cliente deve ser diferente do destinatário")
    end
  end 
end

  




