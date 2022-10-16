class VehiclesController < ApplicationController

  def index 
    @vehicles = Vehicle.all

  end 
  
  def new  
    @vehicle = Vehicle.new
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
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    vehicle_edit_params
    if @vehicle.update(vehicle_edit_params)
      redirect_to vehicles_path
    else
      flash.now[:notice] = 'Não foi possível alterar status.'
      render 'edit'
    end
  end

  def show  
    @vehicle = Vehicle.find(params[:id])
  end

  def search 
    @license_plate = params["query"]
    @status = params["status"]
    @vehicles = Vehicle.where("license_plate LIKE ?", "%#{@license_plate}%").or(Vehicle.where(status: @status))
  end

  private  
  def vehicle_create_params  
    vehicle_create_params = params.require(:vehicle).permit(:brand_name, :model, :fabrication_year, :full_capacity, :license_plate)
  end
  def vehicle_edit_params  
    vehicle_edit_params = params.require(:vehicle).permit(:status)
  end
end