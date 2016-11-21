class InvoiceDashboard
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def invoices
    current_user_invoices.order(created_at: :desc)
  end

  def month_passive
    date = month_params
    invoices.month_passive(date)
  end

  def month_active
    date = month_params
    invoices.month_active(date)
  end

  def general_expenses_passive
    date = month_params
    general_expenses.month_passive(date)
  end

  def general_expenses_active
    date = month_params
    general_expenses.month_active(date)
  end

  def company_passive
    date = month_params
    company_invoices.month_passive(date)
  end

  def company_active
    date = month_params
    company_invoices.month_active(date)
  end

  def vehicle_passive
    date = month_params
    vehicle_invoices.month_passive(date)
  end

  def vehicle_active
    date = month_params
    vehicle_invoices.month_active(date)
  end

  def category_passive
    date = month_params
    category_invoices.month_passive(date)
  end

  def category_active
    date = month_params
    category_invoices.month_active(date)
  end

  def general_expenses
    current_user_invoices.general_expenses
  end

  def calculator
    Calculator.new
  end

  private

  def company_invoices
    current_user_invoices.where(company_id: id)
  end

  def category_invoices
    current_user_invoices.where(category_id: id)
  end

  def vehicle_invoices
    current_user_invoices.where(vehicle_id: id)
  end

  def year_params
    year = params[:year]
    Time.new(year)
  end

  def month_params
    year = params[:year]
    month = params[:month]
    Time.new(year, month)
  end

  def current_user_invoices
    current_user.invoices
  end

  def id
    params[:id]
  end
end
