class InvoicesController < ApplicationController
  before_action :authenticate_user!

  include CheckIfCompanyAndVehicleExists

  def new
    check_if_company_and_vehicle_exists
  end

  def edit
    @category = Category.all
    @new_invoice = NewInvoice.new
  end

  def update
    @invoice = Invoice.find(params[:id])
    params = BuildInvoice.new(invoice_params).build
    if @invoice.update(params)
      flash[:success] = "La fattura e' stata aggiornata"
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
    flash[:success] = 'Fattura elliminata'
    redirect_to :back
  end

  def create
    params = BuildInvoice.new(invoice_params).build
    params[:category_id] = category_id
    @new_invoice = NewInvoice.new
    @invoice = Invoice.new(params)
    if @invoice.save
      redirect_to invoice_path(id: @invoice.id)
    else
      render "new"
    end
  end

  private

  def category_id
    Company.find(company_id).category_id
  end

  def invoice_params
    params.require(:invoice).permit(:reason,:date_of_issue,:company_id,:category_id,:vehicle_id,:deadline,:type_of_invoice,taxable_vat_fields_attributes:[:taxable, :vat_rate,:_destroy,:id])
  end

  def company_id
    invoice_params[:company_id]
  end

end
