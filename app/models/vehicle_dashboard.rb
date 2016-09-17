class VehicleDashboard

  attr_reader :vehicle_id

  def initialize params
    @vehicle_id = params[:id]
    @params = params
  end

  def plate
    vehicle.plate
  end

  def passive_invoices
    vehicle_invoices.passive_ord_by_year(@params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def active_invoices
    vehicle_invoices.active_ord_by_year(@params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def not_paid_invoices
    passive_invoices = vehicle.invoices.passive
    passive_invoices.not_paid
  end

  def not_collected_invoices
    active_invoices = vehicle.invoices.active
    active_invoices.not_collected
  end

  private

  def vehicle
    Vehicle.find(vehicle_id)
  end

  def vehicle_invoices
    vehicle.invoices
  end

end
