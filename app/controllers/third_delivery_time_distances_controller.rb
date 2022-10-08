class ThirdDeliveryTimeDistancesController < ApplicationController

  def new
    @third_delivery_time_distance = ThirdDeliveryTimeDistance.new
  end

  def create
    third_delivery_time_params
    @third_delivery_time_distance = ThirdDeliveryTimeDistance.create(third_delivery_time_params)

    if @third_delivery_time_distance.save
      redirect_to expressas_path, notice: "Intervalo cadastrado com sucesso."
    else  
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  def edit
    @third_delivery_time_distance = ThirdDeliveryTimeDistance.find(params[:id])
  end
  def update 
    third_delivery_time_params
    @third_delivery_time_distance = ThirdDeliveryTimeDistance.find(params[:id])
    if ThirdDeliveryTimeDistance.count > 1
      next_line = ThirdDeliveryTimeDistance.where("id > ?", @third_delivery_time_distance.id).order("id ASC").first.min_distance
      cond = next_line < (params[:third_delivery_time_distance][:max_distance]).to_i
      if @third_delivery_time_distance.update(third_delivery_time_params) && !cond
        redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.' 
      else
        flash.now[:notice] = 'Não foi possível alterar intervalo: distância máxima não pode ser maior que distância mínima do próximo intervalo.'
        render 'edit'
      end
    elsif ThirdDeliveryTimeDistance.count == 1 && @third_delivery_time_distance.update(third_delivery_time_params) 
      redirect_to expressas_path, notice: 'Intervalo alterado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end
  
  def disable_field
    if ThirdDeliveryTimeDistance.any?
      @disable_field = true
    end
    @disable_field = false
  end 
  
  private
  def third_delivery_time_params
    third_delivery_time_params = params.require(:third_delivery_time_distance).permit(:min_distance, :max_distance, :delivery_time, :expressa_id)
  end

end