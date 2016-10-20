class CategoryDashboard

  def initialize params, current_user
    @params = params
    @current_user = current_user
  end

  def category_id
    @params[:id]
  end

  def category_name
    category.category
  end

  private

  def category
    @current_user.categories.find(category_id)
  end

end
