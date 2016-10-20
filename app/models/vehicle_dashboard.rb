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

  def calculator
    Calculator.new
  end

  def vehicles
    @current_user.vehicles.order(plate: :asc)
  end

  def invoices
    invoices_dashboard.vehicle_invoices(vehicle_id)
  end

  private

  def invoices_dashboard
    InvoiceDashboard.new(@current_user, @params)
  end

  def vehicle
    @current_user.vehicles.find(vehicle_id)
  end
end
