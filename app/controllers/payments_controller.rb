class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    payment = Payment.add_to_invoice payment_params, invoice_id
    payment.save
    redirect_to company_invoice_path(company_id: company_id, id: invoice_id)
  end

  private

  def payment_params
    params.require(:payment).permit(:total,:method_of_payment,:date)
  end

  def company_id
    params[:company_id]
  end

  def invoice_id
    params[:invoice_id]
  end
end