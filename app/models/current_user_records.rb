module CurrentUserRecords
  def current_user_companies
    current_user.companies
  end

  def current_user_categories
    current_user.categories
  end

  def current_user_vehicles
    current_user.vehicles
  end

  def current_user_insurances
    current_user.insurances
  end

  def current_user_vehicles_general_expences
    current_user.vehicles.charge_general_expences
  end

  def current_user_invoices
    current_user.invoices
  end

  def current_user_fuel_receipts
    current_user.fuel_receipts
  end

end
