class CompanyDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :company_any?

  def index
    @company_dashboard = CompanyDashboard.new(current_user, params)
  end

  def show
    @company_dashboard = CompanyDashboard.new(current_user, params)
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
end
