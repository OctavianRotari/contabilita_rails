class CompanyDashboard

  def initialize current_user, params
    @current_user = current_user
    @params = params
  end

  def company_id
    @params[:id]
  end

  def company_name
    company.name
  end

  def calculator
    Calculator.new
  end

  def companies
    @current_user.companies
  end

  def invoices
    invoice_dashboard.company_invoices(company_id)
  end

  private

  def company
    @current_user.companies.find(company_id)
  end

  def invoice_dashboard
    InvoiceDashboard.new(@current_user, @params)
  end

end
