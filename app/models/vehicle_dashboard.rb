class VehicleDashboard
  include CurrentUserRecords
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
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

  def vehicle_fuel_receipts
    vehicle.fuel_receipts
  end

  def vehicle_general_expenses
    date = month_params
    vehicle.general_expenses_month(date)
  end

  def vehicle_insurances_month
    date = month_params
    vehicle.insurances_total(date)
  end

  def type_of_vehicle
    vehicle.type_of_vehicle
  end

  def insurances
    vehicle.insurances
  end

  def id
    params[:id]
  end

  def total_month_passive
    date = month_params
    vehicle.passive_invoices_month_total(date)
  end

  def total_fuel_receipts_month
    date = month_params
    vehicle.fuel_receipts_month_total(date)
  end

  def total_costs_month
    date = month_params
    vehicle.current_month_costs(date)
  end

  private

  def vehicle
    current_user_vehicles.find(id)
  end

  def month_params
    year = params[:year]
    month = params[:month]
    Time.new(year, month)
  end
end
