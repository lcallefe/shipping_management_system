class WorkOrdersController < ApplicationController
  def new
    @work_order = WorkOrder.new
  end
  def create
    work_order_params
    @work_order = WorkOrder.new(work_order_params)

    if @work_order.save
      redirect_to root_path, notice: "Ordem de serviço registrada com sucesso."
    else
      flash.now[:notice] = 'Não foi possível registrar ordem de serviço.'
      render 'new'
    end
  end

  def find_shipping_method_price_distance
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
      from sedex_dez sd
      join first_price_distances p on sd.id = p.sedex_dez_id")

    expressa.rows.each do |row|
      if (row[0]..row[1]).include? distance
        @price_distance_expressa = row[2]
        Expressa.find(row[3]).update(work_order_id:@work_order.id)
      end
    end

    sedex.rows.each do |row|
      if (row[0]..row[1]).include? distance
        @price_distance_sedex = row[2]
        Sedex.find(row[3]).update(work_order_id:@work_order.id)
      end
    end

    sedex_dez.rows.each do |row|
      if (row[0]..row[1]).include? distance
        @price_distance_sd = row[2]
        SedexDez.find(row[3]).update(work_order_id:@work_order.id)
      end
    end
  end

  def find_shipping_method_price_weight
    expressa = ActiveRecord::Base.connection.exec_query(
      "select p.min_weight, p.max_weight, p.price, e.id 
      from expressas e 
      join third_price_weights p on e.id = p.expressa_id")

    sedex = ActiveRecord::Base.connection.exec_query(
      "select p.min_weight, p.max_weight, p.price, s.id 
      from sedexes s
      join second_price_weights p on s.id = p.sedex_id")

    sedex_dez = ActiveRecord::Base.connection.exec_query(
      "select p.min_weight, p.max_weight, p.price, sd.id 
      from sedex_dez sd
      join first_price_weights p on sd.id = p.sedex_dez_id")

    expressa.rows.each do |row|
      if (row[0]..row[1]).include? product_weight
        @price_weight_expressa = row[2]
        Expressa.find(row[3]).update(work_order_id:@work_order.id)
      end
    end

    sedex.rows.each do |row|
      if (row[0]..row[1]).include? distance
        @price_weight_sedex = row[2]
        Sedex.find(row[3]).update(work_order_id:@work_order.id)
      end
    end

    sedex_dez.rows.each do |row|
      if (row[0]..row[1]).include? distance
        @price_weight_sedex_dex = row[2]
        SedexDez.find(row[3]).update(work_order_id:@work_order.id)
      end
    end
  end

  def find_shipping_method_delivery_time
    expressa = ActiveRecord::Base.connection.exec_query(
      "select d.min_distance, d.max_distance, d.price 
      from expressas e 
      join third_delivery_time_distances d
      on e.id = d.expressa_id")

    sedex = ActiveRecord::Base.connection.exec_query(
      "select d.min_distance, d.max_distance, d.price 
      from sedexes s
      join second_delivery_time_distances d
      on s.id = d.sedex_id")

    sedex_dez = ActiveRecord::Base.connection.exec_query(
      "select d.min_weight, d.max_weight, d.price 
      from sedex_dez sd
      join first_delivery_time_distances d
      on sd.id = d.sedex_dez_id")

    expressa.rows.each do |row|
      if (row[0]..row[1]).include? product_weight
        @delivery_time_expressa = row[2]
        Expressa.find(row[3]).update(work_order_id:@work_order.id)
      end
    end

    sedex.rows.each do |row|
      if (row[0]..row[1]).include? distance
        @delivery_time_sedex = row[2]
        Sedex.find(row[3]).update(work_order_id:@work_order.id)
      end
    end

    sedex_dez.rows.each do |row|
      if (row[0]..row[1]).include? distance
        @delivery_time_sedex_dez = row[2]
        SedexDez.find(row[3]).update(work_order_id:@work_order.id)
      end
    end
  end

  def calculate_fee
    @work_order = WorkOrder.find(params[:id])
    find_shipping_method_price_weight
    find_shipping_method_price_distance

    fee_expressa = @price_distance_expressa + (@work_order.distance * @price_weight_expressa) + (Expressa.where(work_order_id:@work_order.id).flat_fee)
    fee_sedex = @price_distance_expressa + (@work_order.distance * @price_weight_sedex) + (Sedex.where(work_order_id:@work_order.id).flat_fee)
    fee_sedex_dez = @price_distance_sd + (@work_order.distance * @price_weight_sedex_dez) + (SedexDez.where(work_order_id:@work_order.id).flat_fee)

    a << ['expressa', fee_expressa] if fee_expressa
    a << ['sedex', fee_sedex] if fee_sedex
    a << ['sedex_dez', fee_sedex_dez] if fee_sedex_dez

    a.to_h
  end


  def work_order_params 
    work_order_params = params.require(:work_order).permit(:street, :city, :state, 
    :number, :customer_name, :customer_cpf, :customer_phone_numer, :product_name,
    :product_weight, :sku, :warehouse_street, :warehouse_state, :warehouse_number, 
    :distance, :warehouse_city)
  end



end
