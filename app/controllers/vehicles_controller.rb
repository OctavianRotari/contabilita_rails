class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def create
    vehicle = Vehicle.new(vehicle_params)
    if vehicle.save
      redirect_to vehicles_path
    else
      redirect_to vehicle_new_path
    end
  end

  private
  def vehicle_params
    params.require(:vehicle).permit(:plate, :type_of_vehicle)
  end
end
