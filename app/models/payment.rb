class Payment < ActiveRecord::Base
  belongs_to :invoice

  def self.add_to_invoice payment_params, invoice_id
    if !payment_params[:paid].empty?
      payment = (Invoice.payments(invoice_id)).build(payment_params)
      payment.save
    end
  end
end
