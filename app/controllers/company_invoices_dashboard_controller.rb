class CompanyInvoicesDashboardController < ApplicationController

  def show
    @company_invoices_dashboard = CompanyInvoicesDashboard.new(params[:id])
  end

  def passive_invoices
    @invoices = Company.find(params[:company_invoices_dashboard_id]).invoices.passive_ord_by_year(params)
    @invoices_month = @invoices.group_by { |t| t.date_of_issue.beginning_of_month }
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = Company.find(params[:company_invoices_dashboard_id]).invoices.active_ord_by_year(params)
    @invoices_month = @invoices.group_by { |t| t.date_of_issue.beginning_of_month }
    respond_to do |format|
      format.js
    end
  end

end
