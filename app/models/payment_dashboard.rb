class PaymentDashboard
  attr_reader :payment_params

  def initialize(payment_params)
    @payment_params = payment_params
  end

  def update_invoice
    total_to_pay < 0 ? false : invoice.update(paid: total_to_pay.zero?)
  end

  private

  def total_to_pay
    invoice.total.to_i - invoice_payments
  end

  def invoice_payments
    invoice.total_payments
  end

  def invoice
    Invoice.find(invoice_id)
  end

  def invoice_id
    payment_params[:invoice_id]
  end
end
