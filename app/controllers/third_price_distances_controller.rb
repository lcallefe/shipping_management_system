class ThirdPriceDistancesController < ApplicationController

  def new
    @third_price_distance = ThirdPriceDistance.new
  end

  def create
    third_price_distance_params
    @third_price_distance = ThirdPriceDistance.create(third_price_distance_params)

    if @third_price_distance.save 
      redirect_to expressas_path, notice: 'Intervalo cadastrado com sucesso.'
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
    if ThirdPriceDistance.count > 1
      next_line = ThirdPriceDistance.where("id > ?", @third_price_distance.id).order("id ASC").first.min_distance
      cond = next_line < (params[:third_price_distance][:max_distance]).to_i
      if @third_price_distance.update(third_price_distance_params) && !cond        
        redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Distância máxima deve ser menor que distância mínima do próximo intervalo.'
        render 'edit'
      end
    elsif ThirdPriceDistance.count == 1 && @third_price_distance.update(third_price_distance_params) 
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.'
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