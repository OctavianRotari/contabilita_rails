module CategoriesHelper
  def gas_station?
    current_user.categories.gas_station == nil ? false : true
  end
end
