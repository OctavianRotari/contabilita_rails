class InvoicesController < ApplicationController
  include CheckIfCompanyAndVehicleExists

  def new
    check_if_company_and_vehicle_exists
  end

  def edit
    @category_of_companies = CategoryOfCompany.all
    @new_invoice = NewInvoice.new
    create_company_or_vehicle
  end

  def update
    @invoice = Invoice.find(params[:id])
    params = BuildInvoice.new(invoice_params).build
    if @invoice.update(params)
      flash[:notice] = "La fattura e' stata aggiornata"
      redirect_to invoice_path(invoice_id: @invoice.id)
    else
      render "edit"
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
      render "new"
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
