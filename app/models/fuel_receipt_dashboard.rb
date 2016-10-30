class FuelReceiptDashboard
  def initialize(params, current_user)
    @current_user = current_user
    @params = params
  end

  def id
    @params[:id]
  end

  def company
    Company.find(id)
  end

  def vehicle
    Vehicle.find(id)
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

  def current_user_companies
    @current_user.companies
  end
end
