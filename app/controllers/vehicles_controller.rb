class VehiclesController < ApplicationController
  include CreateVehicle

  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    create_vehicle
  end

  def destroy
    vehicle = Vehicle.find(params[:id])
    vehicle.destroy
    flash[:notice] = 'Mezzo elliminato'
    redirect_to vehicles_path
  end

  def create
    create_vehicle
  end

  private
  def vehicle_params
    params.require(:vehicle).permit(:plate, :type_of_vehicle)
  end
end
