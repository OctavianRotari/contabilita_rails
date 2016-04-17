class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def create
    invoice = Invoice.register params
    if invoice.save
      Payment.add_to_invoice(params_for_payment, invoice.id)
      redirect_to company_path(company_id)
    else
      render new_company_invoice
    end
  end

  private

  def company_id
    params[:company_id]
  end

  def params_for_payment
    params.require(:invoice).permit(:paid,:date,:method_of_payment)
  end

end

