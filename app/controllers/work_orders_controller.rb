class WorkOrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def new
    @work_order = WorkOrder.new
  end
  def index 
    @work_orders = WorkOrder.all
  end
  def create
    work_order_create_params
    @work_order = WorkOrder.new(work_order_create_params)

    if @work_order.save
      redirect_to pending_work_orders_path, notice: "Ordem de serviço registrada com sucesso."
    else
      flash.now[:notice] = 'Não foi possível registrar ordem de serviço.'
      render 'new'
    end
  end

  def pending
    @work_orders = WorkOrder.where(status:0)
    @work_orders_in_progress = WorkOrder.where(status:1)
  end

  def edit
    @work_order = WorkOrder.find(params[:id])
    call_methods
  end

  def update 
    @work_order = WorkOrder.find(params[:id])
    if @work_order.pendente?
      work_order_start_params
      find_shipping_method_delivery_time
      calculate_fee
      # if @work_order[:shipping_method].nil? # como fazer funcionar no model?
      #   flash.now[:notice] = 'Modalidade de entrega não pode ficar em branco'
      #   render 'edit'
      # end
      if @work_order.update(work_order_start_params) && !@work_order.shipping_method.nil?
        set_vehicle
        @work_order[:departure_date] = DateTime.now
        @work_order.em_progresso!
        @vehicle.em_entrega!
        # seta preço e prazo de entrega
        if !@delivery_time_sedex.nil? && @work_order.shipping_method == 'Sedex'
          @work_order[:shipping_expected_date] = @work_order.departure_date + (@delivery_time_sedex/24) 
          @work_order[:total_price] = @fee_sedex
        elsif !@delivery_time_expressa.nil? && @work_order.shipping_method == 'Expressa'  
          @work_order[:shipping_expected_date] = @work_order.departure_date + (@delivery_time_expressa/24)
          @work_order[:total_price] = @fee_expressa
        
        elsif !@delivery_time_sedex_dez.nil? && @work_order.shipping_method == 'Sedex Dez'    
          @work_order[:shipping_expected_date] = @work_order.departure_date + (@delivery_time_sedex_dez/24)
          @work_order[:total_price] = @fee_sedex_dez
        end

        @work_order.save
        redirect_to pending_work_orders_path, notice: 'Ordem de serviço iniciada com sucesso.'
      else
        flash.now[:notice] = 'Modalidade de entrega não pode ficar em branco.'
        render 'edit'
      end
    elsif !@work_order.pendente?
      # complete_work_order_params
      # if @work_order.update(complete_work_order_params)
        @work_order.update(shipping_date: Date.today)
      # end
      if @work_order.shipping_date > @work_order.shipping_expected_date
        if @work_order.update(delay_reason_param)
          @work_order.encerrada_em_atraso!
          Vehicle.find_by(work_order_id:@work_order.id).ativo!
          redirect_to pending_work_orders_path, notice: 'Ordem de serviço encerrada com sucesso.'
        else  
          redirect_to edit_work_order_path(@work_order.id), notice:'Motivo do atraso não pode ficar em branco.' 
        end
      else
        @work_order.encerrada_no_prazo!
        Vehicle.find_by(work_order_id:@work_order.id).ativo!
        redirect_to pending_work_orders_path, notice: 'Ordem de serviço encerrada com sucesso.'
      end
    end
  end
 
  def show   
    @work_order = WorkOrder.find(params[:id]) 
  end

  def search 
    @code = params["query"]
    @work_order = WorkOrder.find_by(code: params["query"])
    @vehicle = Vehicle.find_by(work_order_id:@work_order.id) if !@work_order.nil?
  end

  private
  def call_methods
    calculate_fee
    find_shipping_method_delivery_time
    @delivery_time_expressa
    @delivery_time_sedex 
    @delivery_time_sedex_dez
    @shipping_methods
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
