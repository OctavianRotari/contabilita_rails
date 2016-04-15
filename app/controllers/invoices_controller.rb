class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new

  end

  private

  def params_id
    params[:company_id]
  end
end
