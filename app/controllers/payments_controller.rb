class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @invoice = Invoice.find(invoice_id)
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params_invoice_id)
    @invoice = Invoice.find(invoice_id)
    if @payment.save && payment_dashboard.update_invoice
      flash[:success] = 'Pagamento aggiunto'
      redirect_to invoice_path(id: invoice_id)
    else
      flash[:error] = 'Pagamento superiore al totale da pagare' if payment_dashboard.update_invoice == false
      render 'new'
    end
  end

  def edit
    @invoice = Invoice.find(invoice_id)
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])
    @invoice = @payment.invoice
    payment_dashboard.update_invoice
    if @payment.update(payment_params)
      flash[:success] = 'Pagamento aggiornato'
      redirect_to invoice_path(id: invoice_id)
    else
      render 'edit'
    end
  end

  def destroy
    payment = Payment.find(params[:id])
    payment.destroy
    flash[:success] = 'Pagamento elliminata'
    redirect_to invoice_path(id: invoice_id)
  end

  private

  def payment_params
    params.require(:payment).permit(:paid, :method_of_payment, :payment_date)
  end

  def invoice_id
    @_invoice_id ||= params[:invoice_id]
  end

  def payment_params_invoice_id
    payment_params.merge!(invoice_id: invoice_id)
  end

  def payment_dashboard
    PaymentDashboard.new(payment_params_invoice_id)
  end
end
