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

  def company_fuel_receipts
    company.fuel_receipts
  end

  def gas_station_companies
    current_user_companies.gas_stations
  end

  private

  def current_user_companies
    @current_user.companies
  end
end
