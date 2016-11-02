class FuelReceiptDashboard
  include CurrentUserRecords
  attr_reader :id, :current_user

  def initialize(id, current_user)
    @id = id
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

  def vehicle_fuel_receipts_ord
    vehicle_fuel_receipts.group_by do |ord|
      ord.date_of_issue.beginning_of_month
    end
  end

  def company_fuel_receipts_ord
    company_fuel_receipts.group_by do |ord|
      ord.date_of_issue.beginning_of_month
    end
  end

  def gas_station_companies
    current_user_companies.gas_stations
  end

  private

  def vehicle_fuel_receipts
    vehicle.fuel_receipts
  end

  def company_fuel_receipts
    company.fuel_receipts
  end
end