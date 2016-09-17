class CompanyDashboard

  attr_reader :company_id

  def initialize params
    @company_id = params[:id]
    @params = params
  end

  def company_name
    company.name
  end

  def passive_invoices
    company_invoices.passive_ord_by_year(@params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def active_invoices
    company_invoices.active_ord_by_year(@params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def not_paid_invoices
    passive_invoices = company.invoices.passive
    passive_invoices.not_paid
  end

  def not_collected_invoices
    active_invoices = company.invoices.active
    active_invoices.not_collected
  end

  private

  def company
    Company.find(company_id)
  end

  def company_invoices
    company.invoices
  end

end
