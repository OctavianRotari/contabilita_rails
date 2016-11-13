class InvoiceDashboard
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def invoices
    current_user_invoices.order(created_at: :desc)
  end

  def general_expenses_invoices
    current_user_invoices.where(at_the_expense_of: 'general_expenses')
  end

  def company_invoices
    current_user_invoices.where(company_id: id)
  end

  def vehicle_invoices
    current_user_invoices.where(vehicle_id: id)
  end

  def category_invoices
    current_user_invoices.where(category_id: id)
  end

  def calculator
    Calculator.new
  end

  private

  def current_user_invoices
    current_user.invoices
  end

  def id
    params[:id]
  end
end
