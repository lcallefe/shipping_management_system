class SedexesController < ApplicationController
  def index
    @sedex = Sedex.find(1)
    @price_distances = validate_price_distance_values
    @price_weights = validate_price_weight_values
    @delivery_time_distances = validate_delivery_time_values
  end

  def edit
    @sedex = Sedex.find(params[:id])
  end
  def update
    @sedex = Sedex.find(params[:id])
    if @sedex.update(sedex_params)
      redirect_to sedexes_path, notice: 'Modalidade de entrega alterada com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar modalidade de entrega'
      render 'edit'
    end
  end
  private
  def sedex_params
    sedex_params = params.require(:sedex).permit(:flat_fee, :status)
  end

  def validate_delivery_time_values
    model = SecondDeliveryTimeDistance.all
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
    model = SecondPriceWeight.all
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
    model = SecondPriceDistance.all
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