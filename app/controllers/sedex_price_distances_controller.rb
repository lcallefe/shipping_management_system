class SedexPriceDistancesController < ApplicationController
  before_action :find_price_distance_by_id, only:[:edit, :update]
  before_action :find_params, only:[:create, :update]
  before_action :count, only:[:create, :update]

  def new
    @sedex_price_distance = SedexPriceDistance.new
  end

  def create
    @sedex_price_distance = SedexPriceDistance.create(sedex_price_distance_params)
    
    if @sedex_price_distance.save && SedexPriceDistance.count > @count
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_price_distance.save && SedexPriceDistance.count == @count
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
    if @sedex_price_distance.update(sedex_price_distance_params) && SedexPriceDistance.count == @count
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_price_distance.update(sedex_price_distance_params) && SedexPriceDistance.count < @count  
      redirect_to sedexes_path, notice: 'Intervalo seguinte é inválido e será excluído.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def sedex_price_distance_params
    sedex_price_distance = params.require(:sedex_price_distance).permit(:min_distance, :max_distance, :price)
  end
  def find_price_distance_by_id
    @sedex_price_distance = SedexPriceDistance.find(params[:id])
  end
  def find_params  
    sedex_price_distance_params
  end
  def count  
    @count = SedexPriceDistance.count
  end
end