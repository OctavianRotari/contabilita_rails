class PaymentDashboard
  attr_reader :payment_params

  def initialize(payment_params)
    @payment_params = payment_params
  end

  def check_total
    total_to_pay.zero?
  end

  private

  def invoice_total_payments
    invoice.total_payments.to_i
  end

  def total
    payment_params[:paid].to_i
  end

  def total_to_pay
    invoice.total.to_i - (invoice_total_payments + total)
  end

  def invoice
    Invoice.find(invoice_id)
  end

  def invoice_id
    payment_params[:invoice_id]
  end
end
