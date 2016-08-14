class InvoicesController < ApplicationController

  def new
    @invoice = Invoice.new
    @companies = Company.all
    @vehicles = Vehicle.all
  end

  def edit
    @vehicles = Vehicle.all
    @companies = Company.all
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    params = BuildInvoice.new(invoice_params).build
    invoice.update(params)
    redirect_to invoice_path(invoice_id: invoice.id)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def destroy
    invoice = Invoice.find(params[:id])
    invoice.destroy
    flash[:notice] = 'Fattura elliminata'
    redirect_to company_path(id:company_id)
  end

  def create
    params = BuildInvoice.new(invoice_params).build
    invoice = Invoice.new(params)
    if invoice.save
      redirect_to invoice_path(id: invoice.id)
    else
      render new_invoice
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason,:date_of_issue,:company_id,:vehicle_id,:deadline,:type_of_invoice,taxable_vat_fields_attributes:[:taxable, :vat_rate,:_destroy,:id])
  end

  def company_id
    params[:company_id]
  end

end
