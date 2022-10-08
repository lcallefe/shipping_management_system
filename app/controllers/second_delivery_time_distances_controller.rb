class SecondDeliveryTimeDistancesController < ApplicationController

  def new
    @second_delivery_time_distance = SecondDeliveryTimeDistance.new
  end

  def create
    second_delivery_time_params
    @second_delivery_time_distance = SecondDeliveryTimeDistance.create(second_delivery_time_params)

    if @second_delivery_time_distance.save
      redirect_to sedexes_path, notice: "Intervalo cadastrado com sucesso."
    else  
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @second_delivery_time_distance = SecondDeliveryTimeDistance.find(params[:id])
  end
  def update
    second_delivery_time_params
    @second_delivery_time_distance = SecondDeliveryTimeDistance.find(params[:id])
    if SecondDeliveryTimeDistance.count > 1
      next_line = SecondDeliveryTimeDistance.where("id > ?", @second_delivery_time_distance.id).order("id ASC").first.min_distance
      cond = next_line < (params[:second_delivery_time_distance][:max_distance]).to_i
      if @second_delivery_time_distance.update(second_delivery_time_params) && !cond
        redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Não foi possível alterar intervalo: distância máxima não pode ser maior que distância mínima do próximo intervalo.'
        render 'edit'
      end
    elsif SecondDeliveryTimeDistance.count == 1 && @second_delivery_time_distance.update(second_delivery_time_params) 
      redirect_to sedexes_path, notice: 'Intervalo alterado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def second_delivery_time_params
    second_delivery_time_params = params.require(:second_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :sedex_id)
  end

end