class WorkOrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_work_order, only:[:edit, :update, :show, :complete, :set_deadline_and_price]
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
    if @work_order.pending?
      @shipping_methods = @work_order.check_available_price_and_delivery_times
    end
  end

  def update 
    if @work_order.pending? && @work_order.update(work_order_start_params) && @work_order.set_vehicle 
      @work_order.in_progress!
      set_deadline_and_price
      redirect_to pending_work_orders_path, notice: 'Ordem de serviço iniciada com sucesso.'   
    elsif @work_order.in_progress? 
      complete
    else
      @shipping_methods = @work_order.check_available_price_and_delivery_times
      flash.now[:notice] = 'Não foi possível iniciar a ordem de serviço.'
      render 'edit' 
    end
  end
 
  def show   
  end

  

  def search 
    @code = params["query"]
    @work_order = WorkOrder.find_by(code: params["query"])
    @vehicle = Vehicle.find_by(work_order_id:@work_order.id) if !@work_order.nil?
    flash.now[:notice] = 'Nenhuma ordem de serviço encontrada.' if @work_order.blank?
  end

  def complete 
    @work_order.update(shipping_date:Date.today)
    @vehicle = Vehicle.find_by(work_order_id:@work_order.id)
    if Date.today > @work_order.shipping_expected_date
      if @work_order.update(work_order_complete_params)
        if params[:work_order][:delay_reason].present?
          @work_order.after_deadline!
          @vehicle.active!
          redirect_to pending_work_orders_path, notice: 'Ordem de serviço encerrada com sucesso.'
        else  
          flash.now[:notice] = "Motivo do atraso não pode ficar em branco."
          render 'edit'
        end
      else 
        flash.now[:notice] = "Não foi possível encerrar a ordem de serviço."
      end
    else
      @work_order.within_deadline!
      @vehicle.active!
      redirect_to pending_work_orders_path, notice: 'Ordem de serviço encerrada com sucesso.'
    end
  end
 

  private
  def set_work_order  
    @work_order = WorkOrder.find(params[:id])
  end 

  def set_deadline_and_price
    deadline_and_price_values = @work_order.check_available_price_and_delivery_times
    @work_order.update(departure_date:Date.today)
    @work_order.update(shipping_expected_date: @work_order.departure_date + (deadline_and_price_values[@work_order.shipping_method.downcase.parameterize(separator:'_')][0]/24))
    @work_order.update(total_price: deadline_and_price_values[@work_order.shipping_method.downcase.parameterize(separator:'_')][1])
  end

  def work_order_create_params 
    work_order_create_params = params.require(:work_order).permit(:street, :city, :state, 
    :number, :customer_name, :customer_cpf, :customer_phone_numer, :product_name,
    :product_weight, :sku, :warehouse_street, :warehouse_state, :warehouse_number, 
    :distance, :warehouse_city)
  end

  def work_order_start_params
    work_order_start_params = params.require(:work_order).permit(:shipping_method)
  end

  def work_order_complete_params
    work_order_start_params = params.require(:work_order).permit(:delay_reason)
  end

end
