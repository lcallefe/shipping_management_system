class FirstPriceWeightsController < ApplicationController

  def new
    @first_price_weight = FirstPriceWeight.new
  end

  def create
    first_price_weight_params
    @first_price_weight = FirstPriceWeight.create(first_price_weight_params)
    
    if @first_price_weight.save
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
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
    if FirstPriceWeight.count > 1
      next_line = FirstPriceWeight.where("id > ?", @first_price_weight.id).order("id ASC").first.min_weight
      cond = next_line < (params[:first_price_weight][:max_weight]).to_i
      if @first_price_weight.update(first_price_weight_params) && !cond
        redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Não foi possível alterar intervalo: peso mínimo não pode ser maior que peso máximo do próximo intervalo.'
        render 'edit'
      end
    elsif FirstPriceWeight.count == 1 && @first_price_weight.update(first_price_weight_params) 
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.'
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