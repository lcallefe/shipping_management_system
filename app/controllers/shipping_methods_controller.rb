class ShippingMethodsController < ApplicationController
  def index
    @shipping_methods = ShippingMethod.all
  end
  def show
    @shipping_method = ShippingMethod.find(params[:id])
  end
end