class InvoiceDashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @calculator = Calculator.new
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
  end

  def active_invoices
    @calculator = Calculator.new
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
  end

  def passive_invoices
    @calculator = Calculator.new
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
  end
end
