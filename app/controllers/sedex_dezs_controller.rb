class SedexDezsController < ApplicationController
  before_action :find_sedex_dez_by_id, only:[:edit, :update]

  def index
    @sedex_dez = SedexDez.find(1)
    @price_distances = SedexDezPriceDistance.all
    @price_weights = SedexDezPriceWeight.all
    @delivery_time_distances = SedexDezDeliveryTimeDistance.all
  end

  def edit
  end
  def update
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

  def find_sedex_dez_by_id 
    @sedex_dez = SedexDez.find(params[:id])
  end
end