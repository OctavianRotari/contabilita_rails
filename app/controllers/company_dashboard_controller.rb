class CompanyDashboardController < ApplicationController

  def index
    @category_of_company = CategoryOfCompany.new
    @companies = Company.all.group_by { |t| t.category_of_company_id }
    if params[:commit] == 'Aggiungi categoria'
      @category_of_company = CategoryOfCompany.new(category_params)
      if @category_of_company.save
        flash[:notice] = 'Categoria inserita'
        redirect_to dashboard_companies_path
      else
        render "index"
      end
    end
  end

  def show
    @company_dashboard = CompanyDashboard.new(params)
  end

  def passive_invoices
    @invoices = company_dashboard.passive_invoices
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = company_dashboard.active_invoices
    respond_to do |format|
      format.js
    end
  end

  private

  def company_dashboard
    CompanyDashboard.new(params)
  end

  def category_params
    params.require(:category_of_company).permit(:category)
  end
end
