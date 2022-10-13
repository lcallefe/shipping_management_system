class FirstDeliveryTimeDistancesController < ApplicationController

  def new
    @first_delivery_time_distance = FirstDeliveryTimeDistance.new
  end

  def create
    first_delivery_time_distance_params
    count = FirstDeliveryTimeDistance.count
    @first_delivery_time_distance = FirstDeliveryTimeDistance.create(first_delivery_time_distance_params)
    
    if @first_delivery_time_distance.save && FirstDeliveryTimeDistance.count > count
      redirect_to sedex_dezs_path, notice: 'Intervalo cadastrado com sucesso.'
    elsif @first_delivery_time_distance.save && FirstDeliveryTimeDistance.count == count
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @first_delivery_time_distance = FirstDeliveryTimeDistance.find(params[:id])
  end
  def update
    first_delivery_time_distance_params
    @first_delivery_time_distance = FirstDeliveryTimeDistance.find(params[:id])
    count = FirstDeliveryTimeDistance.count
    if @first_delivery_time_distance.update(first_delivery_time_distance_params) && FirstDeliveryTimeDistance.count == count
      redirect_to sedex_dezs_path, notice: 'Intervalo alterado com sucesso.' 
    elsif @first_delivery_time_distance.update(first_delivery_time_distance_params) && FirstDeliveryTimeDistance.count < count  
      flash.now[:notice] = 'Intervalo inválido.'
      render 'edit'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  private
  def first_delivery_time_distance_params
    first_delivery_time_distance_params = params.require(:first_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :sedex_id)
  end

end