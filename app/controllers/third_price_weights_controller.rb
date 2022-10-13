class ThirdPriceWeightsController < ApplicationController

  def new
    @third_price_weight = ThirdPriceWeight.new
  end

  def create
    third_price_weight_params
    count = ThirdPriceWeight.count
    @third_price_weight = ThirdPriceWeight.create(third_price_weight_params)
    
    if @third_price_weight.save && ThirdPriceWeight.count > count
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @third_price_weight.save && ThirdPriceWeight.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  
  def edit
    @third_price_weight = ThirdPriceWeight.find(params[:id])
  end
  def update
    third_price_weight_params
    @third_price_weight = ThirdPriceWeight.find(params[:id])
    count = ThirdPriceWeight.count
    if @third_price_weight.update(third_price_weight_params) && ThirdPriceWeight.count == count
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @third_price_weight.update(third_price_weight_params) && ThirdPriceWeight.count < count  
      flash.now[:notice] = 'Intervalo seguinte é inválido e será excluído.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def third_price_weight_params
    third_price_weight = params.require(:third_price_weight).permit(:min_weight, :max_weight, :price)
  end
end