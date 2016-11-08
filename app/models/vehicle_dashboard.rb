class VehicleDashboard
  include CurrentUserRecords
  attr_reader :current_user, :vehicle_id

  def initialize(vehicle_id, current_user)
    @vehicle_id = vehicle_id
    @current_user = current_user
  end

  def plate
    vehicle.plate
  end

  def calculator
    @calculator ||= Calculator.new
  end

  def vehicles
    current_user_vehicles.order(plate: :asc)
  end

  def invoices
    vehicle.invoices
  end

  private

  def vehicle
    current_user_vehicles.find(vehicle_id)
  end
end
