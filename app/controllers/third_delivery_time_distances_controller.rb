class ThirdDeliveryTimeDistancesController < ApplicationController

  def new
    @third_delivery_time_distance = ThirdDeliveryTimeDistance.new
  end

  def create
    third_delivery_time_distance_params
    count = ThirdDeliveryTimeDistance.count
    @third_delivery_time_distance = ThirdDeliveryTimeDistance.create(third_delivery_time_distance_params)
    
    if @third_delivery_time_distance.save && ThirdDeliveryTimeDistance.count > count
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @third_delivery_time_distance.save && ThirdDeliveryTimeDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @third_delivery_time_distance = ThirdDeliveryTimeDistance.find(params[:id])
  end
  def update 
    third_delivery_time_distance_params
    @third_delivery_time_distance = ThirdDeliveryTimeDistance.find(params[:id])
    count = ThirdDeliveryTimeDistance.count
    if @third_delivery_time_distance.update(third_delivery_time_distance_params) && ThirdDeliveryTimeDistance.count == count
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @third_delivery_time_distance.update(third_delivery_time_distance_params) && ThirdDeliveryTimeDistance.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def third_delivery_time_distance_params
    third_delivery_time_distance_params = params.require(:third_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :expressa_id)
  end
end