class SecondPriceWeightsController < ApplicationController

  def new
    @second_price_weight = SecondPriceWeight.new
  end

  def create
    second_price_weight_params
    @second_price_weight = SecondPriceWeight.create(second_price_weight_params)
    
    if @second_price_weight.save
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
    else  
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @second_price_weight = SecondPriceWeight.find(params[:id])
  end
  def update
    second_price_weight_params
    @second_price_weight = SecondPriceWeight.find(params[:id])
    if SecondPriceWeight.count > 1
      next_line = SecondPriceWeight.where("id > ?", @second_price_weight.id).order("id ASC").first.min_weight
      cond = next_line < (params[:second_price_weight][:max_weight]).to_i
      if @second_price_weight.update(second_price_weight_params) && !cond
        redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Não foi possível alterar intervalo: peso mínimo não pode ser maior que peso máximo do próximo intervalo.'
        render 'edit'
      end
    elsif SecondPriceWeight.count == 1 && @second_price_weight.update(second_price_weight_params) 
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  private
  def second_price_weight_params
    second_price_weight = params.require(:second_price_weight).permit(:min_weight, :max_weight, :price)
  end
end