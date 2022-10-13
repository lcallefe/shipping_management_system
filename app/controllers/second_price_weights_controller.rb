class SecondPriceWeightsController < ApplicationController

  def new
    @second_price_weight = SecondPriceWeight.new
  end

  def create
    second_price_weight_params
    count = SecondPriceWeight.count
    @second_price_weight = SecondPriceWeight.create(second_price_weight_params)
    
    if @second_price_weight.save && SecondPriceWeight.count > count
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @second_price_weight.save && SecondPriceWeight.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @second_price_weight = SecondPriceWeight.find(params[:id])
  end
  def update
    second_price_weight_params
    @second_price_weight = SecondPriceWeight.find(params[:id])
    count = SecondPriceWeight.count
    if @second_price_weight.update(second_price_weight_params) && SecondPriceWeight.count == count
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @second_price_weight.update(second_price_weight_params) && SecondPriceWeight.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def second_price_weight_params
    second_price_weight = params.require(:second_price_weight).permit(:min_weight, :max_weight, :price)
  end
end