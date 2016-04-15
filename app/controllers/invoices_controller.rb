class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    invoice_with_total = Invoice.calculate_total invoice_params
    invoice = Invoice.build_invoice invoice_with_total, company_id
    if invoice.save
      redirect_to company_path(company_id)
    else
      redirect_to new_company_invoice
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:total, :taxable, :vat, :date, :plate, :deadline, :type_of_payment)
  end

  def company_id
    params[:company_id]
  end
end

