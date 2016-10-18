class CategoryDashboard

  def initialize params, current_user
    @params = params
    @current_user = current_user
  end

  def category_id
    @params[:id]
  end

  def calculator
    Calculator.new
  end

  def category_name
    category.category
  end

  def passive_invoices
    category_invoices.passive_ord_by_year(@params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def active_invoices
    category_invoices.active_ord_by_year(@params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def not_paid_invoices
    passive_invoices = category.invoices.passive
    passive_invoices.not_paid
  end

  def not_collected_invoices
    active_invoices = category.invoices.active
    active_invoices.not_collected
  end

  private

  def category
    @current_user.categories.find(category_id)
  end

  def category_invoices
    category.invoices
  end

end
