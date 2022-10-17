class SedexesController < ApplicationController
  before_action :find_sedex_by_id, only:[:edit, :update]

  def index
    @sedex = Sedex.find(1)
    @price_distances = SedexPriceDistance.all
    @price_weights = SedexPriceWeight.all
    @delivery_time_distances = SedexDeliveryTimeDistance.all
  end

  def edit
    
  end

  def update
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
  def find_sedex_by_id  
    @sedex = Sedex.find(params[:id])
  end
end