class InvoicesController < ApplicationController
  include CreateCompanyOrVehicleFromInvoiceNew
  include CheckIfCompanyAndVehicleExists

  def new
    @category_of_companies = CategoryOfCompany.all
    check_if_company_and_vehicle_exists
  end

  def edit
    @new_invoice = NewInvoice.new
  end

  def update
    invoice = Invoice.find(params[:id])
    params = BuildInvoice.new(invoice_params).build
    if invoice.update(params)
      redirect_to invoice_path(invoice_id: invoice.id)
    else
      flash[:notice] = 'La modifica non e andata a buon fine controllare i dati inseriti'
      redirect_to edit_invoice_path(invoice_id: params[:id])
    end
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
    @new_invoice = NewInvoice.new
    @invoice = Invoice.new(params)
    if @invoice.save
      redirect_to invoice_path(id: @invoice.id)
    else
      render new_invoice_path
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason,:date_of_issue,:company_id,:vehicle_id,:deadline,:type_of_invoice,taxable_vat_fields_attributes:[:taxable, :vat_rate,:_destroy,:id])
  end

  def company_id
    params[:company_id]
  end

  def company_params
    params.require(:company).permit(:name, :adress, :number)
  end

  def vehicle_params
    params.require(:vehicle).permit(:plate, :type_of_vehicle)
  end

end
