class SecondPriceDistancesController < ApplicationController

  def new
    @second_price_distance = SecondPriceDistance.new
  end

  def create
    second_price_distance_params
    @second_price_distance = SecondPriceDistance.create(second_price_distance_params)

    if @second_price_distance.save 
      redirect_to sedexes_path, notice: 'Intervalo cadastrado com sucesso.'
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
    if SecondPriceDistance.count > 1
      next_line = SecondPriceDistance.where("id > ?", @second_price_distance.id).order("id ASC").first.min_distance
      cond = next_line < (params[:second_price_distance][:max_distance]).to_i
      if @second_price_distance.update(second_price_distance_params) && !cond        
        redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Distância máxima deve ser menor que distância mínima do próximo intervalo.'
        render 'edit'
      end
    elsif SecondPriceDistance.count == 1 && @second_price_distance.update(second_price_distance_params) 
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.'
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