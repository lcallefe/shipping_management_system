class ExpressaDeliveryTimeDistancesController < ApplicationController

  def new
    @expressa_delivery_time_distance = ExpressaDeliveryTimeDistance.new
  end

  def create
    expressa_delivery_time_distance_params
    count = ExpressaDeliveryTimeDistance.count
    @expressa_delivery_time_distance = ExpressaDeliveryTimeDistance.create(expressa_delivery_time_distance_params)
    
    if @expressa_delivery_time_distance.save && ExpressaDeliveryTimeDistance.count > count
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @expressa_delivery_time_distance.save && ExpressaDeliveryTimeDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @expressa_delivery_time_distance = ExpressaDeliveryTimeDistance.find(params[:id])
  end
  def update 
    expressa_delivery_time_distance_params
    @expressa_delivery_time_distance = ExpressaDeliveryTimeDistance.find(params[:id])
    count = ExpressaDeliveryTimeDistance.count
    if @expressa_delivery_time_distance.update(expressa_delivery_time_distance_params) && ExpressaDeliveryTimeDistance.count == count
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @expressa_delivery_time_distance.update(expressa_delivery_time_distance_params) && ExpressaDeliveryTimeDistance.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def expressa_delivery_time_distance_params
    expressa_delivery_time_distance_params = params.require(:expressa_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :expressa_id)
  end
end