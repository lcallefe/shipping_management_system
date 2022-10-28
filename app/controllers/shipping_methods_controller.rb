class ShippingMethodsController < ApplicationController
  before_action :find_shipping_method_by_id, only:[:edit, :update]
  before_action :shipping_method_params, only:[:create, :show]


  def index
    @shipping_methods = ShippingMethod.all
  end

  def new 
    @shipping_method = ShippingMethod.new
  end

  def create  
    @shipping_method = ShippingMethod.new(shipping_method_params)
    
    if @shipping_method.save!  
      redirect_to @shipping_method, notice: 'Modalidade de transporte cadastrada com sucesso'
    else  
      flash.now[:notice] = 'Não foi possível cadastrar modalidade de transporte'
      render 'new'
    end
  end  

  def show  

  end

  def edit
  end
  
  def update
    if @shipping_method.update(shipping_method_params)
      redirect_to shipping_methods_path, notice: 'Modalidade de transporte alterada com sucesso.'
    end
    flash.now[:notice] = 'Não foi possível alterar modalidade de transporte'
    render 'edit'  
  end

  private
  def shipping_method_params
    shipping_method_params = params.require(:shipping_method).permit(:flat_fee, :status, :name, :min_weight, :min_distance,
                                                                     :max_distance, :max_weight)
  end

  def find_shipping_method_by_id
    @shipping_method = ShippingMethod.find(params[:id])
  end
end