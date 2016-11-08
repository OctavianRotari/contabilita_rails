class CompanyDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :company_any?

  def index
    @company_dashboard = CompanyDashboard.new(company_id, current_user)
  end

  def show
    @company_dashboard = CompanyDashboard.new(company_id, current_user)
  end

  def passive_invoices
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  private

  def company_id
    params[:id]
  end
end
