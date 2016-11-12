class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_any?
  before_action :company_any?

  def new
    @companies = companies
    @vehicles = vehicles
    @invoice = Invoice.new
  end

  def edit
    @companies = companies
    @vehicles = vehicles
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    build_params = build_invoice.build
    if @invoice.update(build_params)
      flash[:success] = "La fattura e' stata aggiornata"
      redirect_to invoice_path(invoice_id: @invoice.id)
    else
      render 'edit'
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def destroy
    invoice = Invoice.find(params[:id])
    invoice.destroy
    flash[:success] = 'Fattura elliminata'
    redirect_after_destroy(current_user_invoices)
  end

  def create
    @companies = companies
    @vehicles = vehicles
    build_params = build_invoice.build
    @invoice = Invoice.new(build_params)
    if @invoice.save
      flash[:success] = 'Fattura aggiunta'
      redirect_to invoice_path(id: @invoice.id)
    else
      render 'new'
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason,:date_of_issue,:company_id,:category_id,:at_the_expense_of,:deadline,:type_of_invoice,taxable_vat_fields_attributes:[:taxable, :vat_rate,:_destroy,:id])
  end

  def invoice_params_user_id
    invoice_params.merge!(user_id: current_user[:id])
  end

  def companies
    @_companies ||= current_user_companies
  end

  def vehicles
    @_vehicles ||= current_user_vehicles
  end

  def build_invoice
    BuildInvoice.new(invoice_params_user_id)
  end
end
