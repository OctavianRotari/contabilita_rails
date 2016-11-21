class FuelReceiptDashboard
  include CurrentUserRecords
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def company
    Company.find(id)
  end

  def vehicle
    Vehicle.find(id)
  end

  def calculator
    @calculator ||= Calculator.new
  end

  def vehicle_fuel_receipts_month
    date = month_params
    vehicle_fuel_receipts.month(date)
  end

  def company_fuel_receipts_month
    date = month_params
    company_fuel_receipts.month(date)
  end

  def gas_station_companies
    current_user_companies.gas_stations
  end

  private

  def id
    params[:id]
  end

  def vehicle_fuel_receipts
    vehicle.fuel_receipts
  end

  def company_fuel_receipts
    company.fuel_receipts
  end

  def month_params
    year = params[:year]
    month = params[:month]
    Time.new(year, month)
  end
end
