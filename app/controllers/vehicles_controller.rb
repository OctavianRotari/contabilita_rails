class VehiclesController < ApplicationController
  before_action :authenticate_user!

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
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      flash[:success] = 'Mezzo aggiornato'
      redirect_to dashboard_vehicles_path
    else
      render 'edit'
    end
  end

  def destroy
    vehicle = Vehicle.find(params[:id])
    vehicle.destroy
    flash[:success] = 'Mezzo elliminato'
    if current_user.vehicles.count > 0
      redirect_to :back
    else
      redirect_to dashboard_invoices_path
    end
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle[:user_id] = current_user[:id]
    if @vehicle.save
      flash[:success] = 'Mezzo aggiunto'
      redirect_to dashboard_vehicles_path
    else
      render 'new'
    end
  end

  private
  def vehicle_params
    params.require(:vehicle).permit(:plate, :type_of_vehicle)
  end
end
