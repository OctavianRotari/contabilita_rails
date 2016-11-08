class CategoryDashboard
  include CurrentUserRecords

  attr_reader :current_user, :category_id

  def initialize(category_id, current_user)
    @category_id = category_id
    @current_user = current_user
  end

  def categories
    current_user_categories.order(name: :asc)
  end

  def calculator
    @calculator ||= Calculator.new
  end

  def invoices
    category.invoices
  end

  def category_name
    category.name
  end

  private

  def category
    current_user_categories.find(category_id)
  end
end
