class ThirdPriceDistancesController < ApplicationController

  def new
    @third_price_distance = ThirdPriceDistance.new
  end

  def create
    third_price_distance_params
    count = ThirdPriceDistance.count
    @third_price_distance = ThirdPriceDistance.create(third_price_distance_params)
    
    if @third_price_distance.save && ThirdPriceDistance.count > count
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @third_price_distance.save && ThirdPriceDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @third_price_distance = ThirdPriceDistance.find(params[:id])
  end
  def update
    third_price_distance_params
    @third_price_distance = ThirdPriceDistance.find(params[:id])
    count = ThirdPriceDistance.count
    if @third_price_distance.update(third_price_distance_params) && ThirdPriceDistance.count == count
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @third_price_distance.update(third_price_distance_params) && ThirdPriceDistance.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def third_price_distance_params
    third_price_distance = params.require(:third_price_distance).permit(:min_distance, :max_distance, :price)
  end
end