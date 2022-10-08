class ThirdPriceWeightsController < ApplicationController

  def new
    @third_price_weight = ThirdPriceWeight.new
  end

  def create
    third_price_weight_params
    @third_price_weight = ThirdPriceWeight.create(third_price_weight_params)
    
    if @third_price_weight.save
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
    else  
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @third_price_weight = ThirdPriceWeight.find(params[:id])
  end
  def update
    third_price_weight_params
    @third_price_weight = ThirdPriceWeight.find(params[:id])
    if ThirdPriceWeight.count > 1
      next_line = ThirdPriceWeight.where("id > ?", @third_price_weight.id).order("id ASC").first.min_weight
      cond = next_line < (params[:third_price_weight][:max_weight]).to_i
      if @third_price_weight.update(third_price_weight_params) && !cond
        redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Não foi possível alterar intervalo: peso mínimo não pode ser maior que peso máximo do próximo intervalo.'
        render 'edit'
      end
    elsif ThirdPriceWeight.count == 1 && @third_price_weight.update(third_price_weight_params) 
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def third_price_weight_params
    third_price_weight = params.require(:third_price_weight).permit(:min_weight, :max_weight, :price)
  end
end