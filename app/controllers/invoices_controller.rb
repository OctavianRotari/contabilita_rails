class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    params = Invoice.build(invoice_params)
    invoice.update(params)
    redirect_to company_invoice_path(company_id:company_id, invoice_id: invoice.id)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    flash[:notice] = 'Fattura elliminata'
    redirect_to company_path(company_id)
  end

  def create
    params = Invoice.build(invoice_params)
    invoice = Invoice.add_to(company_id, params)
    if invoice.save
      Payment.add_to_invoice(params_for_payment, invoice.id)
      redirect_to company_path(company_id)
    else
      render new_company_invoice
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason,:taxable_1,:vat_1,:taxable_2,:vat_2,:taxable_3,:vat_3,:date_of_issue,:plate,:deadline)
  end

  def company_id
    params[:company_id]
  end

  def params_for_payment
    params.require(:invoice).permit(:paid,:payment_date,:method_of_payment)
  end

end

