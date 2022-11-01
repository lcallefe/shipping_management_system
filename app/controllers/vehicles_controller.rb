class VehiclesController < ApplicationController
  before_action :find_vehicle_by_id, only:[:edit, :update, :show]

  def index 
    @vehicles = Vehicle.all
  end 
  
  def new  
    @vehicle = Vehicle.new(params[:shipping_method_id])
    @shipping_methods = ShippingMethod.all
  end

  def create  
    vehicle_create_params
    @vehicle = Vehicle.new(vehicle_create_params)

    if @vehicle.save
      redirect_to vehicles_path, notice: "Veículo cadastrado com sucesso."
    else
      flash.now[:notice] = 'Não foi possível cadastrar veículo.'
      render 'new'
    end
  end

  def edit
  end

  def update
    vehicle_edit_params
    if @vehicle.update(vehicle_edit_params)
      redirect_to vehicles_path
    else
      flash.now[:notice] = 'Não foi possível alterar status.'
      render 'edit'
    end
  end

  def show  
  end

  def search 
    @license_plate = params["query"]
    @status = params["status"]
    if @license_plate.nil? || @license_plate.empty?
      @vehicles = Vehicle.where("license_plate LIKE ?", "").or(Vehicle.where(status: @status))
      flash.now[:notice] = 'Nenhum veículo encontrado.' if @vehicles.blank?
    else   
      @vehicles = Vehicle.where("license_plate LIKE ?", "%#{@license_plate}%").or(Vehicle.where(status: @status))
      flash.now[:notice] = 'Nenhum veículo encontrado.' if @vehicles.blank?
    end
  end 

  private  
  def vehicle_create_params  
    params[:shipping_method_id] = 
    vehicle_create_params = params.require(:vehicle).permit(:brand_name, :model, :fabrication_year, 
                                                            :full_capacity, :license_plate,
                                                            :shipping_method_id)
  end

  def vehicle_edit_params  
    vehicle_edit_params = params.require(:vehicle).permit(:status)
  end
  
  def find_vehicle_by_id  
    @vehicle = Vehicle.find(params[:id])
  end
end