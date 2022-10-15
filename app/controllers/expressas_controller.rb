class ExpressasController < ApplicationController
  def index
    @expressa = Expressa.last
    @price_distances = ExpressaPriceDistance.all
    @price_weights = ExpressaPriceWeight.all
    @delivery_time_distances = ExpressaDeliveryTimeDistance.all
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
end