class ExpressasController < ApplicationController
  def index
    @expressa = Expressa.find(1)
    @price_distances = validate_price_distance_values
    @price_weights = validate_price_weight_values
    @delivery_time_distances = validate_delivery_time_values
  end

  def new 
    @expressa = Expressa.new
  end

  def edit
    @expressa = Expressa.find(params[:id])
  end
  def update
    @expressa = Expressa.find(params[:id])
    if @expressa.update(expressa_params)
      redirect_to expressas_path, notice: 'Modalidade de entrega alterada com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar modalidade de entrega'
      render 'edit'
    end
  end
  private
  def expressa_params
    expressa_params = params.require(:expressa).permit(:flat_fee, :status)
  end

  def validate_delivery_time_values
    model = ThirdDeliveryTimeDistance.all
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
    model = ThirdPriceWeight.all
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
    model = ThirdPriceDistance.all
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