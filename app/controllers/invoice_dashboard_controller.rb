class InvoiceDashboardController < ApplicationController
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
    invoice_dashboard.passive_ord_by_year(params)
  end

  def active(params)
    invoice_dashboard.active_ord_by_year(params)
  end
end
