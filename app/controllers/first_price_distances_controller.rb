class FirstPriceDistancesController < ApplicationController

  def new
    @first_price_distance = FirstPriceDistance.new
  end

  def create
    first_price_distance_params
    @first_price_distance = FirstPriceDistance.create(first_price_distance_params)

    if @first_price_distance.save 
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
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
    if FirstPriceDistance.count > 1
      next_line = FirstPriceDistance.where("id > ?", @first_price_distance.id).order("id ASC").first.min_distance
      cond = next_line < (params[:first_price_distance][:max_distance]).to_i
      if @first_price_distance.update(first_price_distance_params) && !cond        
        redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Distância máxima deve ser menor que distância mínima do próximo intervalo.'
        render 'edit'
      end
    elsif FirstPriceDistance.count == 1 && @first_price_distance.update(first_price_distance_params) 
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.'
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