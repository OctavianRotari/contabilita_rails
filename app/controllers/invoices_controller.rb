class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def company_invoices
    @invoices = Company.find(params_id).invoices
    render "index"
  end

  private

  def params_id
    params[:company_id]
  end
end
