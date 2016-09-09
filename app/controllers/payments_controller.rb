class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @payment = Payment.new
  end

  def create
    payment = Payment.new(payment_params)
    payment.invoice_id = invoice_id
    if payment.save
      redirect_to invoice_path(id: invoice_id)
    else
      new_invoice_payment_path(invoice_id: invoice_id)
    end
  end

  def edit
    @invoice = Invoice.find(params[:invoice_id])
    @payment = Payment.find(params[:id])
  end

  def update
    payment = Payment.find(params[:id])
    payment.update(payment_params)
    if payment.update(payment_params)
      redirect_to invoice_path(id: invoice_id)
    else
      flash[:notice] = 'La modifica non e andata a buon fine controllare i dati inseriti'
      redirect_to edit_invoice_payment_path(invoice_id: invoice_id, id:payment.id)
    end
  end

  def destroy
    payment = Payment.find(params[:id])
    payment.destroy
    flash[:notice] = 'Pagamento elliminata'
    redirect_to invoice_path(id: invoice_id)
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
