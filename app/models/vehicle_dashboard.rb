class VehicleDashboard

  def initialize params, current_user
    @params = params
    @current_user = current_user
  end

  def plate
    vehicle.plate
  end

  def vehicle_id
    @params[:id]
  end

  private

  def vehicle
    @current_user.vehicles.find(vehicle_id)
  end
end
