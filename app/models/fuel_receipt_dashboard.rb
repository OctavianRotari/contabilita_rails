class FuelReceiptDashboard
  def initialize(current_user)
    @current_user = current_user
  end

  def gas_station_companies
    current_user_companies.gas_stations
  end

  def company(id)
    current_user_companies.find(id)
  end

  def company_receipts(id)
    company(id).fuel_receipts
  end

  def vehicle_fuel_receips(company_id)
    company_receipts(company_id).group_by{|t| t.vehicle_id}
  end

  private

  def current_user_companies
    @current_user.companies
  end
end
