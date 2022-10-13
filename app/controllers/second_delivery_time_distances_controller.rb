class SecondDeliveryTimeDistancesController < ApplicationController

  def new
    @second_delivery_time_distance = SecondDeliveryTimeDistance.new
  end

  def create
    second_delivery_time_distance_params
    count = SecondDeliveryTimeDistance.count
    @second_delivery_time_distance = SecondDeliveryTimeDistance.create(second_delivery_time_distance_params)
    
    if @second_delivery_time_distance.save && SecondDeliveryTimeDistance.count > count
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @second_delivery_time_distance.save && SecondDeliveryTimeDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @second_delivery_time_distance = SecondDeliveryTimeDistance.find(params[:id])
  end
  def update
    second_delivery_time_distance_params
    @second_delivery_time_distance = SecondDeliveryTimeDistance.find(params[:id])
    count = SecondDeliveryTimeDistance.count
    if @second_delivery_time_distance.update(second_delivery_time_distance_params) && SecondDeliveryTimeDistance.count == count
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @second_delivery_time_distance.update(second_delivery_time_distance_params) && SecondDeliveryTimeDistance.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def second_delivery_time_distance_params
    second_delivery_time_distance_params = params.require(:second_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :sedex_id)
  end

end