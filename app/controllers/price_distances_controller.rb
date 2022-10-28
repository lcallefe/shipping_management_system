class PriceDistancesController < ApplicationController
  before_action :set_price_distance, only:[:edit, :update]
  before_action :find_params, only:[:create, :update]
  before_action :count, only:[:create, :update]


  def new
    @expressa_price_distance = PriceDistance.new
  end

  def create
    @expressa_price_distance = PriceDistance.create(expressa_price_distance_params)
    
    if @expressa_price_distance.save && PriceDistance.count > @count
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @expressa_price_distance.save && PriceDistance.count == @count
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
    if @expressa_price_distance.update(expressa_price_distance_params) && PriceDistance.count == @count
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @expressa_price_distance.update(expressa_price_distance_params) && PriceDistance.count < @count  
      redirect_to expressas_path, notice: 'Intervalo seguinte é inválido e será excluído.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end

  private
  def expressa_price_distance_params
    expressa_price_distance = params.require(:expressa_price_distance).permit(:min_distance, :max_distance, :price)
  end
  def set_price_distance  
    @expressa_price_distance = PriceDistance.find(params[:id])
  end

  def find_params  
    expressa_price_distance_params
  end

  def count  
    @count = PriceDistance.count
  end
end