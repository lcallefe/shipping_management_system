class PriceDistancesController < ApplicationController
  before_action :set_price_distance, only:[:edit, :update]
  before_action :price_distance_params, only:[:create, :update]
  before_action :admin, only:[:create, :update, :new, :edit]

  def new
    @price_distance = PriceDistance.new(shipping_method_id: params[:shipping_method_id])
  end

  def create
    @price_distance = PriceDistance.new(price_distance_params)
    if @price_distance.save 
      redirect_to shipping_method_path(ShippingMethod.find_by(id:@price_distance.shipping_method_id)), 
                                       notice: 'Intervalo cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @price_distance.update(price_distance_params)
      redirect_to shipping_method_path(ShippingMethod.find_by(id:@price_distance.shipping_method_id)), 
                                       notice: 'Intervalo alterado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end

  private
  def price_distance_params
    price_distance = params.require(:price_distance).permit(:min_distance, :max_distance, :price, :shipping_method_id)
  end

  def set_price_distance  
    @price_distance = PriceDistance.find(params[:id])
  end
end