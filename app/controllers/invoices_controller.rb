class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_general_expences_any?
  before_action :category_any?
  before_action :company_any?

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @companies = companies
    @vehicles = vehicles
    @invoice = Invoice.new
  end

  def create
    @companies = companies
    @vehicles = vehicles
    build_params = build_invoice.build
    @invoice = Invoice.new(build_params)
    if @invoice.save
      flash[:success] = 'Fattura aggiunta'
      redirect_to invoice_path(@invoice.id)
    else
      render 'new'
    end
  end

  def edit
    @companies = companies
    @vehicles = vehicles
    @invoice = Invoice.find(params[:id])
  end

  def update
    @vehicles = vehicles
    @companies = companies
    @invoice = Invoice.find(params[:id])
    build_params = build_invoice.build
    if @invoice.update(build_params)
      flash[:success] = "La fattura e' stata aggiornata"
      redirect_to invoice_path(@invoice.id)
    else
      render 'edit'
    end
  end

  def destroy
    invoice = Invoice.find(params[:id])
    invoice.destroy
    flash[:success] = 'Fattura elliminata'
    redirect_after_destroy(current_user_invoices)
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reason,
                                    :date_of_issue,
                                    :company_id,
                                    :serial_number,
                                    :category_id,
                                    :vehicle_id,
                                    :at_the_expense_of,
                                    :deadline,
                                    :type_of_invoice,
                                    taxable_vat_fields_attributes: [:taxable, :vat_rate,:_destroy,:id],
                                    vehicle_field_attributes: [:vehicle_id,:_destroy, :part_of_total, :id])
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
