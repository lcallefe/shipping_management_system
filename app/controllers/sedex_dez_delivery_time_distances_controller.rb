class SedexDezDeliveryTimeDistancesController < ApplicationController
  before_action :find_delivery_time_by_id, only:[:edit, :update]
  before_action :sedex_dez_delivery_time_distance_params, only:[:create, :update]
  before_action :count, only:[:create, :update]

  def new
    @sedex_dez_delivery_time_distance = SedexDezDeliveryTimeDistance.new
  end

  def create
    @sedex_dez_delivery_time_distance = SedexDezDeliveryTimeDistance.create(sedex_dez_delivery_time_distance_params)
    
    if @sedex_dez_delivery_time_distance.save && SedexDezDeliveryTimeDistance.count > @count
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_dez_delivery_time_distance.save && SedexDezDeliveryTimeDistance.count == @count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @sedex_dez_delivery_time_distance.update(sedex_dez_delivery_time_distance_params) && SedexDezDeliveryTimeDistance.count == @count
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_dez_delivery_time_distance.update(sedex_dez_delivery_time_distance_params) && SedexDezDeliveryTimeDistance.count < @count  
      redirect_to sedex_dezs_path, notice: 'Intervalo seguinte é inválido e será excluído.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def sedex_dez_delivery_time_distance_params
    sedex_dez_delivery_time_distance_params = params.require(:sedex_dez_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :sedex_id)
  end

  def find_delivery_time_by_id
    @sedex_dez_delivery_time_distance = SedexDezDeliveryTimeDistance.find(params[:id])
  end

  def count  
    @count = SedexDezDeliveryTimeDistance.count
  end
end