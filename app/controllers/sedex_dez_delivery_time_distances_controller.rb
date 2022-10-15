class SedexDezDeliveryTimeDistancesController < ApplicationController

  def new
    @sedex_dez_delivery_time_distance = SedexDezDeliveryTimeDistance.new
  end

  def create
    sedex_dez_delivery_time_distance_params
    count = SedexDezDeliveryTimeDistance.count
    @sedex_dez_delivery_time_distance = SedexDezDeliveryTimeDistance.create(sedex_dez_delivery_time_distance_params)
    
    if @sedex_dez_delivery_time_distance.save && SedexDezDeliveryTimeDistance.count > count
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_dez_delivery_time_distance.save && SedexDezDeliveryTimeDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @sedex_dez_delivery_time_distance = SedexDezDeliveryTimeDistance.find(params[:id])
  end
  def update
    sedex_dez_delivery_time_distance_params
    @sedex_dez_delivery_time_distance = SedexDezDeliveryTimeDistance.find(params[:id])
    count = SedexDezDeliveryTimeDistance.count
    if @sedex_dez_delivery_time_distance.update(sedex_dez_delivery_time_distance_params) && SedexDezDeliveryTimeDistance.count == count
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_dez_delivery_time_distance.update(sedex_dez_delivery_time_distance_params) && SedexDezDeliveryTimeDistance.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def sedex_dez_delivery_time_distance_params
    sedex_dez_delivery_time_distance_params = params.require(:sedex_dez_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :sedex_id)
  end

end