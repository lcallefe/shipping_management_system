class ShippingMethodsController < ApplicationController
  def index
    @shipping_methods = ShippingMethod.all
  end
end