class InvoiceDashboard
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def invoices
    current_user_invoices.order(created_at: :desc)
  end

  def year_passive
    date = year_params
    invoices.year_passive(date)
  end

  def year_active
    date = year_params
    invoices.year_active(date)
  end

  def general_expenses_passive
    date = year_params
    general_expenses.year_passive(date)
  end

  def general_expenses_active
    date = year_params
    general_expenses.year_active(date)
  end

  def company_passive
    date = year_params
    company_invoices.year_passive(date)
  end

  def company_active
    date = year_params
    company_invoices.year_active(date)
  end

  def vehicle_passive
    date = year_params
    vehicle_invoices.year_passive(date)
  end

  def vehicle_active
    date = year_params
    vehicle_invoices.year_active(date)
  end

  def category_passive
    date = year_params
    category_invoices.year_passive(date)
  end

  def category_active
    date = year_params
    category_invoices.year_active(date)
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

  def current_user_invoices
    current_user.invoices
  end

  def id
    params[:id]
  end
end
