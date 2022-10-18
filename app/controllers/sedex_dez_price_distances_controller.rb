class SedexDezPriceDistancesController < ApplicationController
  before_action :find_price_distance_by_id, only:[:edit, :update]
  before_action :sedex_dez_price_distance_params, only:[:create, :update]
  before_action :count, only:[:create, :update]
  def new
    @sedex_dez_price_distance = SedexDezPriceDistance.new
  end

  def create
    @sedex_dez_price_distance = SedexDezPriceDistance.create(sedex_dez_price_distance_params)
    
    if @sedex_dez_price_distance.save && SedexDezPriceDistance.count > @count
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_dez_price_distance.save && SedexDezPriceDistance.count == @count
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
    if @sedex_dez_price_distance.update(sedex_dez_price_distance_params) && SedexDezPriceDistance.count == @count
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_dez_price_distance.update(sedex_dez_price_distance_params) && SedexDezPriceDistance.count < @count  
      redirect_to sedex_dezs_path, notice: 'Intervalo seguinte é inválido e será excluído.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def sedex_dez_price_distance_params
    sedex_dez_price_distance = params.require(:sedex_dez_price_distance).permit(:min_distance, :max_distance, :price)
  end

  def find_price_distance_by_id 
    @sedex_dez_price_distance = SedexDezPriceDistance.find(params[:id])
  end

  def count  
    @count = SedexDezPriceDistance.count
  end
end