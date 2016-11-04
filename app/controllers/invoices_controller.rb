class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    if current_user.companies.empty?
      flash[:error] = "Aggiungere almeno un'azienda"
      redirect_to :back
    elsif current_user.vehicles.empty?
      flash[:error] = 'Aggiungere almeno un mezzo'
      redirect_to :back
    end
  end

  def new
    @companies = current_user.companies
    @vehicles = current_user.vehicles
    @invoice = Invoice.new
  end

  def edit
    @companies = current_user.companies
    @vehicles = current_user.vehicles
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    params = BuildInvoice.new(invoice_params).build
    if @invoice.update(params)
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
    redirect_after_destroy(curre_user_invoices)
  end

  def create
    @companies = current_user.companies
    @vehicles = current_user.vehicles
    params = BuildInvoice.new(invoice_params_user_id).build
    @invoice = Invoice.new(params)
    if @invoice.save
      flash[:success] = 'Fattura aggiunta'
      redirect_to invoice_path(id: @invoice.id)
    else
      render 'new'
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason,:date_of_issue,:company_id,:category_id,:vehicle_id,:deadline,:type_of_invoice,taxable_vat_fields_attributes:[:taxable, :vat_rate,:_destroy,:id])
  end

  def invoice_params_user_id
    invoice_params.merge!(user_id: current_user[:id])
  end
end
