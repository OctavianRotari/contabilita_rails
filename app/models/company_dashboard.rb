class CompanyDashboard

  def initialize params, current_user
    @params = params
    @current_user = current_user
  end

  def company_id
    @params[:id]
  end
  def company_name
    company.name
  end

  private

  def company
    @current_user.companies.find(company_id)
  end

end
