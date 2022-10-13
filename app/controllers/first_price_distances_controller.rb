class FirstPriceDistancesController < ApplicationController

  def new
    @first_price_distance = FirstPriceDistance.new
  end

  def create
    first_price_distance_params
    count = FirstPriceDistance.count
    @first_price_distance = FirstPriceDistance.create(first_price_distance_params)
    
    if @first_price_distance.save && FirstPriceDistance.count > count
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @first_price_distance.save && FirstPriceDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @first_price_distance = FirstPriceDistance.find(params[:id])
  end
  def update
    first_price_distance_params
    @first_price_distance = FirstPriceDistance.find(params[:id])
    count = FirstPriceDistance.count
    if @first_price_distance.update(first_price_distance_params) && FirstPriceDistance.count == count
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @first_price_distance.update(first_price_distance_params) && FirstPriceDistance.count < count  
      flash.now[:notice] = 'Intervalo seguinte é inválido e será excluído.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def first_price_distance_params
    first_price_distance = params.require(:first_price_distance).permit(:min_distance, :max_distance, :price)
  end
end