class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    Payment.add_to_invoice payment_params, invoice_id
    redirect_to company_invoice_path(company_id: company_id, id: invoice_id)
  end

  private

  def payment_params
    params.require(:payment).permit(:paid,:method_of_payment,:payment_date)
  end

  def company_id
    params[:company_id]
  end

  def invoice_id
    params[:invoice_id]
  end
end
