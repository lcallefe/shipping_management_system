class SedexDezPriceWeightsController < ApplicationController
  before_action :find_price_weight_by_id, only:[:edit, :update]
  before_action :sedex_dez_price_weight_params, only:[:create, :update]
  before_action :count, only:[:create, :update]

  def new
    @sedex_dez_price_weight = SedexDezPriceWeight.new
  end

  def create
    @sedex_dez_price_weight = SedexDezPriceWeight.create(sedex_dez_price_weight_params)
    
    if @sedex_dez_price_weight.save && SedexDezPriceWeight.count > @count
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @sedex_dez_price_weight.save && SedexDezPriceWeight.count == @count
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
    if @sedex_dez_price_weight.update(sedex_dez_price_weight_params) && SedexDezPriceWeight.count == @count
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @sedex_dez_price_weight.update(sedex_dez_price_weight_params) && SedexDezPriceWeight.count < @count  
      redirect_to sedex_dezs_path, notice: 'Intervalo seguinte é inválido e será excluído.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def sedex_dez_price_weight_params
    sedex_dez_price_weight = params.require(:sedex_dez_price_weight).permit(:min_weight, :max_weight, :price)
  end

  def find_price_weight_by_id
    @sedex_dez_price_weight = SedexDezPriceWeight.find(params[:id])
  end

  def count  
    @count = SedexDezPriceWeight.count
  end
end