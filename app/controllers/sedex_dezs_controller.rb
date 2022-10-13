class SedexDezsController < ApplicationController
  def index
    @sedex_dez = SedexDez.find(1)
    @price_distances = FirstPriceDistance.all
    @price_weights = FirstPriceWeight.all
    @delivery_time_distances = FirstDeliveryTimeDistance.all
  end

  def edit
    @sedex_dez = SedexDez.find(params[:id])
  end
  def update
    @sedex_dez = SedexDez.find(params[:id])
    if @sedex_dez.update(sedex_dez_params)
      redirect_to sedex_dezes_path, notice: 'Modalidade de entrega alterada com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar modalidade de entrega'
      render 'edit'
    end
  end
  private
  def sedex_dez_params
    sedex_dez_params = params.require(:sedex_dez).permit(:flat_fee, :status)
  end

  def validate_delivery_time_values
    model = FirstDeliveryTimeDistance.all
    if model.count > 1
      model.each_with_index do |dt,i|
        if dt.id > model[i-1].id
          if (dt.delivery_time < model[i-1].delivery_time || dt.min_distance < model[i-1].min_distance || dt.max_distance < model[i-1].max_distance)
              dt.destroy
              flash.now[:notice] = 'Intervalo não é válido, por favor verifique e tente novamente.'
          end
        end
      end
    end
    model
  end

  def validate_price_weight_values
    model = FirstPriceWeight.all
    if model.count > 1
      model.each_with_index do |pw,i|
        if pw.id > model[i-1].id
          if (pw.min_weight < model[i-1].min_weight || pw.max_weight < model[i-1].max_weight|| pw.price < model[i-1].price || pw.min_weight < model[i-1].max_weight)
              pw.destroy
              flash.now[:notice] = 'Intervalo não é válido, por favor verifique e tente novamente.'
          end
        end
      end
    end
    model
  end

  def validate_price_distance_values
    model = FirstPriceDistance.all
    if model.count > 1
      model.each_with_index do |pd,i|
        if pd.id > model[i-1].id
          if (pd.price < model[i-1].price || pd.min_distance < model[i-1].min_distance || pd.max_distance < model[i-1].max_distance)
              pd.destroy
              flash.now[:notice] = 'Intervalo não é válido, por favor verifique e tente novamente.'
          end
        end
      end
    end
    model
  end
end