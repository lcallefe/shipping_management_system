class SedexPriceDistancesController < ApplicationController

  def new
    @sedex_price_distance = SedexPriceDistance.new
  end

  def create
    sedex_price_distance_params
    count = SedexPriceDistance.count
    @sedex_price_distance = SedexPriceDistance.create(sedex_price_distance_params)
    
    if @sedex_price_distance.save && SedexPriceDistance.count > count
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_price_distance.save && SedexPriceDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @sedex_price_distance = SedexPriceDistance.find(params[:id])
  end
  def update
    sedex_price_distance_params
    @sedex_price_distance = SedexPriceDistance.find(params[:id])
    count = SedexPriceDistance.count
    if @sedex_price_distance.update(sedex_price_distance_params) && SedexPriceDistance.count == count
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_price_distance.update(sedex_price_distance_params) && SedexPriceDistance.count < count  
      flash.now[:notice] = 'Intervalo seguinte é inválido e será excluído.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def sedex_price_distance_params
    sedex_price_distance = params.require(:sedex_price_distance).permit(:min_distance, :max_distance, :price)
  end
end