class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def clients_and_supliers_invoices
    @invoices = ClientsAndSupplier.find(params_id).invoices
    render "index"
  end

  private

  def params_id
    params[:clients_and_supplier_id]
  end
end
