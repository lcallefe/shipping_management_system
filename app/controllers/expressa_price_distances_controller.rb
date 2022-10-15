class ExpressaPriceDistancesController < ApplicationController

  def new
    @expressa_price_distance = ExpressaPriceDistance.new
  end

  def create
    expressa_price_distance_params
    count = ExpressaPriceDistance.count
    @expressa_price_distance = ExpressaPriceDistance.create(expressa_price_distance_params)
    
    if @expressa_price_distance.save && ExpressaPriceDistance.count > count
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @expressa_price_distance.save && ExpressaPriceDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @expressa_price_distance = ExpressaPriceDistance.find(params[:id])
  end
  def update
    expressa_price_distance_params
    @expressa_price_distance = ExpressaPriceDistance.find(params[:id])
    count = ExpressaPriceDistance.count
    if @expressa_price_distance.update(expressa_price_distance_params) && ExpressaPriceDistance.count == count
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @expressa_price_distance.update(expressa_price_distance_params) && ExpressaPriceDistance.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def expressa_price_distance_params
    expressa_price_distance = params.require(:expressa_price_distance).permit(:min_distance, :max_distance, :price)
  end
end