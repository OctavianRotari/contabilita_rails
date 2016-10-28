module CategoriesHelper
  def gas_station?
    Category.gas_station == nil ? false : true
  end
end
