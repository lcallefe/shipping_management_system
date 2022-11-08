class WorkOrdersController < ApplicationController
  before_action :set_work_order, only:[:edit, :update, :show, :complete, :set_deadline_and_price]
  before_action :admin, only:[:new, :create]

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
      @shipping_methods = @work_order.check_available_prices_and_delivery_times
    end
  end

  def update 
    if @work_order.pending? && @work_order.set_vehicle 
      @work_order.in_progress!
      @work_order.set_deadline_and_price
      redirect_to pending_work_orders_path, notice: 'Ordem de serviço iniciada com sucesso.'   
    elsif @work_order.in_progress? 
      complete
    else
      @shipping_methods = @work_order.check_available_prices_and_delivery_times
      flash.now[:notice] = 'Não foi possível iniciar a ordem de serviço.'
      render 'edit' 
    end
  end
 
  def show   
  end

  def search
    @code = params["query"]
    @work_order = WorkOrder.find_by(code: params["query"])
    @vehicle = Vehicle.find_by(shipping_method_id:@work_order.shipping_method) if !@work_order.nil?
  end

  def complete 
    @work_order.update(shipping_date:Date.today)
    @vehicle = Vehicle.find_by(shipping_method_id: @work_order.shipping_method)
    
    if Date.today > @work_order.shipping_expected_date
      if @work_order.update(work_order_complete_params)
        delay_check
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

  def work_order_create_params 
    work_order_create_params = params.require(:work_order).permit(:street, :city, :state, 
    :number, :customer_name, :customer_cpf, :customer_phone_numer, :product_name,
    :product_weight, :sku, :warehouse_street, :warehouse_state, :warehouse_number, 
    :distance, :warehouse_city)
  end

  def delay_check 
    if params[:work_order][:delay_reason].present?
      @work_order.after_deadline!
      @vehicle.active!
      redirect_to pending_work_orders_path, notice: 'Ordem de serviço encerrada com sucesso.'
    else  
      flash.now[:notice] = "Motivo do atraso não pode ficar em branco."
      render 'edit'
    end
  end

  def work_order_start_params
    work_order_start_params = params.require(:work_order).permit(:shipping_method)
  end

  def work_order_complete_params
    work_order_start_params = params.require(:work_order).permit(:delay_reason)
  end
end
