class CategoryDashboard

  def initialize params, current_user
    @params = params
    @current_user = current_user
  end

  def category_id
    @params[:id]
  end

  def categories
    @current_user.categories.order(name: :asc)
  end

  def calculator
    Calculator.new
  end

  def invoices
    invoices_dashboard.category_invoices(category_id)
  end

  def category_name
    category.name
  end

  private

  def invoices_dashboard
    InvoiceDashboard.new(@current_user, @params)
  end

  def category
    @current_user.categories.find(category_id)
  end

end
