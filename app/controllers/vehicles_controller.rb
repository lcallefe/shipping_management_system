class VehiclesController < ApplicationController

  def index 
    @vehicles = Vehicle.all

  end  

  def search 
    @q = Vehicle.ransack(params[:license_plate])
    @vehicle = @q.result
    @status = Vehicle.ransack(status_in: Vehicle.statuses.keys).result
  end

end