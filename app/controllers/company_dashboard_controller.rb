class CompanyDashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @calculator = Calculator.new
    @category_of_company = Category.new
    @companies = Company.all.group_by { |t| t.category_id }
  end

  def show
    @calculator = Calculator.new
    @company_dashboard = CompanyDashboard.new(params)
  end


  def passive_invoices
    @invoices = company_dashboard.passive_invoices
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = company_dashboard.active_invoices
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  private

  def company_dashboard
    CompanyDashboard.new(params)
  end

  def category_params
    params.require(:category).permit(:category)
  end

end
