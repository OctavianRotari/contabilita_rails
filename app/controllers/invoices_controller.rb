class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    invoice = Invoice.calculate_total invoice_params
    invoice_new = Invoice.add_to_company invoice, company_id
    if invoice_new.save
      redirect_to company_path(company_id)
    else
      redirect_to new_company_invoice
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason, :taxable, :vat, :taxable_1, :vat_1, :taxable_2, :vat_2, :date, :plate, :deadline, :type_of_payment)
  end

  def company_id
    params[:company_id]
  end
end

