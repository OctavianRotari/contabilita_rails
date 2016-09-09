class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.invoice_id = invoice_id
    if @payment.save
      redirect_to invoice_path(id: invoice_id)
    else
      render 'new'
    end
  end

  def edit
    @invoice = Invoice.find(params[:invoice_id])
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])
    @payment.update(payment_params)
    if @payment.update(payment_params)
      flash[:notice] = 'Pagamento aggiornato'
      redirect_to invoice_path(id: invoice_id)
    else
      render 'edit'
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
