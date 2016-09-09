class InvoiceDashboardController < ApplicationController
  before_action :authenticate_user!

  def active_invoices
    @invoices = active(params)
  end

  def passive_invoices
    @invoices = passive(params)
  end

  private

  def invoice_dashboard
    InvoiceDashboard.new
  end

  def passive(params)
    invoice_dashboard.passive(params)
  end

  def active(params)
    invoice_dashboard.active(params)
  end
end
