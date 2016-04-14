class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoices = ClientsAndSupplier.invoices params_id
  end

  private

  def params_id
    Invoice.find(params[:id])
  end
end
