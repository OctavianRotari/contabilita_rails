class VehiclesController < ApplicationController
  include CreateVehicle

  def index
    @vehicles = Vehicle.all
    @vehicle = Vehicle.new
    if params[:commit] == "Aggiungi mezzo"
      create_vehicle
    end
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
    vehicle = Vehicle.find(params[:id])
    if vehicle.update(vehicle_params)
      redirect_to vehicles_path
    else
      flash[:notice] = 'La modifica non e andata a buon fine controllare i dati inseriti'
      redirect_to edit_vehicle_path(params[:id])
    end
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
