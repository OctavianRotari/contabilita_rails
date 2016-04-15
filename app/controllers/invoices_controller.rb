class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    invoice = Invoice.build_invoice invoice_params, company_id
    if invoice.save
      redirect_to company_path(company_id)
    else
      redirect_to new_company_invoice
    end
  end

  private
  def invoice_params
    params.require(:invoice).permit(:total, :date, :plate, :deadline, :type_of_payment)
  end

  def company_id
    params[:company_id]
  end
end

