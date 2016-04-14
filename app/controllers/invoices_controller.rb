class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def company_invoices
    @invoices = Invoice.by_company params_id
    render "index"
  end

  private

  def params_id
    params[:company_id]
  end
end
