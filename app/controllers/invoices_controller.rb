class InvoicesController < ApplicationController
  include AddPaymentToInvoice
  include AddToParents

  def active_index
    @invoices = Invoice.active
  end

  def passive_index
    @invoices = Invoice.passive
  end

  def new
    @invoice = Invoice.new
    @vehicles = Vehicle.all
  end

  def edit
    @vehicles = Vehicle.all
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)
    redirect_to company_invoice_path(company_id:company_id, invoice_id: invoice.id)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def destroy
    invoice = Invoice.find(params[:id])
    invoice.destroy
    flash[:notice] = 'Fattura elliminata'
    if invoice.type_of_invoice == 'passiva'
      redirect_to company_passive_invoices_path(company_id)
    else
      redirect_to company_active_invoices_path(company_id)
    end
  end

  def create
    params = BuildInvoice.new(invoice_params).build
    invoice = add_to_parents(company_id, params)
    if invoice.save
      if invoice.type_of_invoice == 'passiva'
        redirect_to company_passive_invoices_path(company_id)
      else
        redirect_to company_active_invoices_path(company_id)
      end
    else
      render new_company_invoice
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason,:taxable_1,:vat_1,:taxable_2,:vat_2,:taxable_3,:vat_3,:date_of_issue,:vehicle_id,:deadline,:type_of_invoice)
  end

  def company_id
    params[:company_id]
  end

end
