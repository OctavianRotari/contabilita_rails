class VehicleDashboard
  include CurrentUserRecords
  attr_reader :id, :current_user

  def initialize(id, current_user)
    @id = id
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
    current_user_vehicles.find(id)
  end
end
