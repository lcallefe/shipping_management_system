class SedexPriceWeightsController < ApplicationController
  before_action :find_price_weight_by_id, only:[:edit, :update]
  before_action :find_params, only:[:create, :update]
  before_action :count, only:[:create, :update]

  def new
    @sedex_price_weight = SedexPriceWeight.new
  end

  def create
    @sedex_price_weight = SedexPriceWeight.create(sedex_price_weight_params)
    
    if @sedex_price_weight.save && SedexPriceWeight.count > @count
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_price_weight.save && SedexPriceWeight.count == @count
      redirect_to sedexes_path, notice: 'Intervalo seguinte é inválido e será excluído.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @sedex_price_weight.update(sedex_price_weight_params) && SedexPriceWeight.count == @count
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_price_weight.update(sedex_price_weight_params) && SedexPriceWeight.count < @count  
      redirect_to sedexes_path, notice: 'Intervalo seguinte é inválido e será excluído.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def sedex_price_weight_params
    sedex_price_weight = params.require(:sedex_price_weight).permit(:min_weight, :max_weight, :price)
  end
  def find_price_weight_by_id  
    @sedex_price_weight = SedexPriceWeight.find(params[:id])
  end
  def find_params  
    sedex_price_weight_params
  end

  def count  
    @count = SedexPriceWeight.count
  end
end