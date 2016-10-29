class FuelReceiptDashboard
  def initialize(current_user)
    @current_user = current_user
  end

  def gas_station_companies
    current_user_companies.gas_stations
  end

  private

  def current_user_companies
    @current_user.companies
  end
end
