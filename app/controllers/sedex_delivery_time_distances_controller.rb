class SedexDeliveryTimeDistancesController < ApplicationController

  def new
    @sedex_delivery_time_distance = SedexDeliveryTimeDistance.new
  end

  def create
    sedex_delivery_time_distance_params
    count = SedexDeliveryTimeDistance.count
    @sedex_delivery_time_distance = SedexDeliveryTimeDistance.create(sedex_delivery_time_distance_params)
    
    if @sedex_delivery_time_distance.save && SedexDeliveryTimeDistance.count > count
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_delivery_time_distance.save && SedexDeliveryTimeDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @sedex_delivery_time_distance = SedexDeliveryTimeDistance.find(params[:id])
  end
  def update
    sedex_delivery_time_distance_params
    @sedex_delivery_time_distance = SedexDeliveryTimeDistance.find(params[:id])
    count = SedexDeliveryTimeDistance.count
    if @sedex_delivery_time_distance.update(sedex_delivery_time_distance_params) && SedexDeliveryTimeDistance.count == count
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_delivery_time_distance.update(sedex_delivery_time_distance_params) && SedexDeliveryTimeDistance.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def sedex_delivery_time_distance_params
    sedex_delivery_time_distance_params = params.require(:sedex_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :sedex_id)
  end

end