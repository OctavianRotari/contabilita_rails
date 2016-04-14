class InvoicesController < ApplicationController
  def index
    byebug
    @invoices = Invoice.all
  end

  def show
    #@invoices = Supplier.invoices params_id
  end

  private

  def params_id
    Invoice.find(params[:id])
  end
end
