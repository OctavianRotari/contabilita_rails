class CompanyDashboardController < ApplicationController

  def index
    @companies = Company.all.group_by { |t| t.category_of_company_id }
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

end
