class SedexPriceWeightsController < ApplicationController

  def new
    @sedex_price_weight = SedexPriceWeight.new
  end

  def create
    sedex_price_weight_params
    count = SedexPriceWeight.count
    @sedex_price_weight = SedexPriceWeight.create(sedex_price_weight_params)
    
    if @sedex_price_weight.save && SedexPriceWeight.count > count
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_price_weight.save && SedexPriceWeight.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @sedex_price_weight = SedexPriceWeight.find(params[:id])
  end
  def update
    sedex_price_weight_params
    @sedex_price_weight = SedexPriceWeight.find(params[:id])
    count = SedexPriceWeight.count
    if @sedex_price_weight.update(sedex_price_weight_params) && SedexPriceWeight.count == count
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_price_weight.update(sedex_price_weight_params) && SedexPriceWeight.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def sedex_price_weight_params
    sedex_price_weight = params.require(:sedex_price_weight).permit(:min_weight, :max_weight, :price)
  end
end