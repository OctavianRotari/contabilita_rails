module AddPaymentToInvoice
  def add_payment_to_invoice payment_params, invoice_id
    if !payment_params[:paid].empty?
      payment = Invoice.build(payment_params, invoice_id)
      payment.save
    end
  end
end
