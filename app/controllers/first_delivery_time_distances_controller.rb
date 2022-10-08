class FirstDeliveryTimeDistancesController < ApplicationController

  def new
    @first_delivery_time_distance = FirstDeliveryTimeDistance.new
  end

  def create
    first_delivery_time_params
    @first_delivery_time_distance = FirstDeliveryTimeDistance.create(first_delivery_time_params)

    if @first_delivery_time_distance.save
      redirect_to sedex_dezs_path, notice: "Intervalo cadastrado com sucesso."
    else  
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @first_delivery_time_distance = FirstDeliveryTimeDistance.find(params[:id])
  end
  def update
    first_delivery_time_params
    @first_delivery_time_distance = FirstDeliveryTimeDistance.find(params[:id])
    if FirstDeliveryTimeDistance.count > 1
      next_line = FirstDeliveryTimeDistance.where("id > ?", @first_delivery_time_distance.id).order("id ASC").first.min_distance
      cond = next_line < (params[:first_delivery_time_distance][:max_distance]).to_i
      if @first_delivery_time_distance.update(first_delivery_time_params) && !cond
        redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Não foi possível alterar intervalo: distância máxima não pode ser maior que distância mínima do próximo intervalo.'
        render 'edit'
      end
    elsif FirstDeliveryTimeDistance.count == 1 && @first_delivery_time_distance.update(first_delivery_time_params) 
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def first_delivery_time_params
    first_delivery_time_params = params.require(:first_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :sedex_id)
  end

end