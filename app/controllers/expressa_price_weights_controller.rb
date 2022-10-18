class ExpressaPriceWeightsController < ApplicationController
  before_action :set_expressa_price_weight, only:[:edit, :update]
  before_action :expressa_price_weight_params, only:[:create, :update]
  before_action :count, only:[:create, :update]


  def new
    @expressa_price_weight = ExpressaPriceWeight.new
  end

  def create
    @expressa_price_weight = ExpressaPriceWeight.create(expressa_price_weight_params)
    
    if @expressa_price_weight.save && ExpressaPriceWeight.count > @count
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @expressa_price_weight.save && ExpressaPriceWeight.count == @count
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
    count = ExpressaPriceWeight.count
    if @expressa_price_weight.update(expressa_price_weight_params) && ExpressaPriceWeight.count == @count
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @expressa_price_weight.update(expressa_price_weight_params) && ExpressaPriceWeight.count < @count  
      redirect_to expressas_path, notice: 'Intervalo seguinte é inválido e será excluído.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def expressa_price_weight_params
    expressa_price_weight = params.require(:expressa_price_weight).permit(:min_weight, :max_weight, :price)
  end

  def set_expressa_price_weight  
    @expressa_price_weight = ExpressaPriceWeight.find(params[:id])
  end

  def count 
    @count = ExpressaPriceWeight.count 
  end
end