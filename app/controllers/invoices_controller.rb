class InvoicesController < ApplicationController
  before_filter :get_company, only: [:new, :create]

  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    invoice = @company.invoices.build(invoice_params)
    if invoice.save
      redirect_to company_path(@company.id)
    else
      redirect_to new_company_invoice
    end
  end

  private
  def invoice_params
    params.require(:invoice).permit(:total, :date, :plate, :deadline, :type_of_payment)
  end

  def get_company
    @company = Company.find(params[:company_id])
  end
end

