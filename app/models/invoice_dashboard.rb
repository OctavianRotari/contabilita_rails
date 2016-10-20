class InvoiceDashboard

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
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

  def calculator
    Calculator.new
  end

end
