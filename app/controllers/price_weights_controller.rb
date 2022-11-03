class PriceWeightsController < ApplicationController
  before_action :set_price_weight, only:[:edit, :update]
  before_action :price_weight_params, only:[:create, :update]
  before_action :admin, only:[:create, :update, :new, :edit]

  def new
    @price_weight = PriceWeight.new(shipping_method_id: params[:shipping_method_id])
  end

  def create
    @price_weight = PriceWeight.new(price_weight_params)
    if @price_weight.save 
      redirect_to shipping_method_path(ShippingMethod.find_by(id:@price_weight.shipping_method_id)), 
                                       notice: 'Intervalo cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível cadastrar intervalo, por favor verifique e tente novamente.'
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @price_weight.update(price_weight_params) 
      redirect_to shipping_method_path(ShippingMethod.find_by(id:@price_weight.shipping_method_id)), 
                                       notice: 'Intervalo cadastrado com sucesso.'
                                       
    else
      flash.now[:notice] = 'Não foi possível alterar intervalo, por favor verifique e tente novamente.'
      render 'edit'
    end
  end

  private
  def price_weight_params
    price_weight = params.require(:price_weight).permit(:min_weight, :max_weight, :price, :shipping_method_id)
  end

  def set_price_weight  
    @price_weight = PriceWeight.find(params[:id])
  end
end