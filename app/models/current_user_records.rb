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
end
