class Payment < ActiveRecord::Base
  belongs_to :invoice

  def self.add_to_invoice payment_params, invoice_id
    (Invoice.payments(invoice_id)).build(payment_params)
  end
end
