class InvoicesController < ApplicationController

  def active_index
    @invoices = Invoice.where("cast(strftime('%Y', date_of_issue) as int) = ?", params[:year_param] ).active
    @invoices_month = @invoices.group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def passive_index
    @invoices = Invoice.where("cast(strftime('%Y', date_of_issue) as int) = ?", params[:year_param] ).passive
    @invoices_month = @invoices.group_by { |t| t.date_of_issue.beginning_of_month }
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
    params = BuildInvoice.new(invoice_params).build
    invoice.update(params)
    redirect_to company_invoice_path(company_id:company_id, invoice_id: invoice.id)
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
    invoice.company_id = company_id
    if invoice.save
      redirect_to company_invoice_path(company_id:company_id, id: invoice.id)
    else
      render new_company_invoice
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason,:date_of_issue,:vehicle_id,:deadline,:type_of_invoice,taxable_vat_fields_attributes:[:taxable, :vat_rate,:_destroy,:id])
  end

  def company_id
    params[:company_id]
  end

end
