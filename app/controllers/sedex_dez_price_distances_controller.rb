class SedexDezPriceDistancesController < ApplicationController

  def new
    @sedex_dez_price_distance = SedexDezPriceDistance.new
  end

  def create
    sedex_dez_price_distance_params
    count = SedexDezPriceDistance.count
    @sedex_dez_price_distance = SedexDezPriceDistance.create(sedex_dez_price_distance_params)
    
    if @sedex_dez_price_distance.save && SedexDezPriceDistance.count > count
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_dez_price_distance.save && SedexDezPriceDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @sedex_dez_price_distance = SedexDezPriceDistance.find(params[:id])
  end
  def update
    sedex_dez_price_distance_params
    @sedex_dez_price_distance = SedexDezPriceDistance.find(params[:id])
    count = SedexDezPriceDistance.count
    if @sedex_dez_price_distance.update(sedex_dez_price_distance_params) && SedexDezPriceDistance.count == count
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_dez_price_distance.update(sedex_dez_price_distance_params) && SedexDezPriceDistance.count < count  
      flash.now[:notice] = 'Intervalo seguinte é inválido e será excluído.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def sedex_dez_price_distance_params
    sedex_dez_price_distance = params.require(:sedex_dez_price_distance).permit(:min_distance, :max_distance, :price)
  end
end