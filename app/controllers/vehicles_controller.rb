class VehiclesController < ApplicationController
  before_action :authenticate_user!

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
    if @vehicle.update(vehicle_params_user_id)
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
    redirect_after_destroy(current_user_vehicles)
  end

  def create
    @vehicle = Vehicle.new(vehicle_params_user_id)
    if @vehicle.save
      flash[:success] = 'Mezzo aggiunto'
      redirect_to dashboard_vehicles_path
    else
      flash[:error] = 'Mezzo non aggiunto'
      render 'new'
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:plate, :type_of_vehicle)
  end

  def vehicle_params_user_id
    vehicle_params.merge!(user_id: current_user.id)
  end
end
