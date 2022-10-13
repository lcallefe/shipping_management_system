class FirstPriceWeightsController < ApplicationController

  def new
    @first_price_weight = FirstPriceWeight.new
  end

  def create
    first_price_weight_params
    count = FirstPriceWeight.count
    @first_price_weight = FirstPriceWeight.create(first_price_weight_params)
    
    if @first_price_weight.save && FirstPriceWeight.count > count
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @first_price_weight.save && FirstPriceWeight.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @first_price_weight = FirstPriceWeight.find(params[:id])
  end
  def update
    first_price_weight_params
    @first_price_weight = FirstPriceWeight.find(params[:id])
    count = FirstPriceWeight.count
    if @first_price_weight.update(first_price_weight_params) && FirstPriceWeight.count == count
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @first_price_weight.update(first_price_weight_params) && FirstPriceWeight.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def first_price_weight_params
    first_price_weight = params.require(:first_price_weight).permit(:min_weight, :max_weight, :price)
  end
end