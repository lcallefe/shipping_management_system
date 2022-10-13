class SecondPriceDistancesController < ApplicationController

  def new
    @second_price_distance = SecondPriceDistance.new
  end

  def create
    second_price_distance_params
    count = SecondPriceDistance.count
    @second_price_distance = SecondPriceDistance.create(second_price_distance_params)
    
    if @second_price_distance.save && SecondPriceDistance.count > count
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @second_price_distance.save && SecondPriceDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @second_price_distance = SecondPriceDistance.find(params[:id])
  end
  def update
    second_price_distance_params
    @second_price_distance = SecondPriceDistance.find(params[:id])
    count = SecondPriceDistance.count
    if @second_price_distance.update(second_price_distance_params) && SecondPriceDistance.count == count
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @second_price_distance.update(second_price_distance_params) && SecondPriceDistance.count < count  
      flash.now[:notice] = 'Intervalo seguinte é inválido e será excluído.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def second_price_distance_params
    second_price_distance = params.require(:second_price_distance).permit(:min_distance, :max_distance, :price)
  end
end