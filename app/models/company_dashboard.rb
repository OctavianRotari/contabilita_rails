class CompanyDashboard
  include CurrentUserRecords

  attr_reader :current_user, :company_id

  def initialize(company_id, current_user)
    @company_id = company_id
    @current_user = current_user
  end

  def company_name
    company.name
  end

  def calculator
    @calculator ||= Calculator.new
  end

  def companies
    current_user_companies.order(name: :asc)
  end

  def invoices
    company.invoices
  end

  private

  def company
    current_user_companies.find(company_id)
  end
end
