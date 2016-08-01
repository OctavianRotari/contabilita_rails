class CompanyDashboardController < ApplicationController

  def show
    @company_invoices_dashboard = CompanyDashboard.new(params)
  end

  def passive_invoices
    @invoices = company_passive_invoices
    @invoices_month = company_passive_invoices.group_by { |t| t.date_of_issue.beginning_of_month }
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = company_active_invoices
    @invoices_month = company_active_invoices.group_by { |t| t.date_of_issue.beginning_of_month }
    respond_to do |format|
      format.js
    end
  end

  private

  def company_active_invoices
    company_dashboard.active_invoices
  end

  def company_passive_invoices
    company_dashboard.passive_invoices
  end

  def company_dashboard
    CompanyDashboard.new(params)
  end

end
