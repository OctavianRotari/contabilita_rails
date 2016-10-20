class InvoiceDashboard

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def passive
    passive_ord_by_year(@params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def invoices
    @current_user.invoices
  end

  def id
    @params[:id]
  end

  def garage_invoices
    @current_user.invoices.where(at_the_expense_of: "Officina")
  end

  def company_invoices(id)
    @current_user.invoices.where(company_id: id)
  end

  def vehicle_invoices(id)
    @current_user.invoices.where(vehicle_id: id)
  end

  def category_invoices(id)
    @current_user.invoices.where(category_id: id)
  end

  private

  def all_invoices
    @current_user.invoices
  end

  def active_invoices(params)
    all_invoices.active_ord_by_year(params)
  end

  def passive_invoices(params)
    all_invoices.passive_ord_by_year(params)
  end

end
