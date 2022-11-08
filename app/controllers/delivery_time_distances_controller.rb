class DeliveryTimeDistancesController < ApplicationController
  before_action :set_time_distance, only:[:edit, :update]
  before_action :delivery_time_distance_params, only:[:create, :update]
  before_action :admin, only:[:create, :update, :new, :edit]

  def new
    @delivery_time_distance = DeliveryTimeDistance.new(shipping_method_id: params[:shipping_method_id])
  end

  def create
    @delivery_time_distance = DeliveryTimeDistance.new(delivery_time_distance_params)
    
    if @delivery_time_distance.save
      redirect_to shipping_method_path(@delivery_time_distance.shipping_method), notice: 'Intervalo cadastrado com sucesso.' 
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end

  def edit
  end

  def update 
    if @delivery_time_distance.update(delivery_time_distance_params)
       redirect_to shipping_method_path(@delivery_time_distance.shipping_method), notice: 'Intervalo alterado com sucesso.' 
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def delivery_time_distance_params
    delivery_time_distance_params = params.require(:delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :shipping_method_id)
  end

  def set_time_distance   
    @delivery_time_distance = DeliveryTimeDistance.find(params[:id])
  end
end