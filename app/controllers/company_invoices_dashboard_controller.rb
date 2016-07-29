class CompanyInvoicesDashboardController < ApplicationController

  def show
    @company_invoices_dashboard = CompanyInvoicesDashboard.new(params[:id])
  end

end
