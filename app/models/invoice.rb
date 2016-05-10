class Invoice < ActiveRecord::Base
  attr_accessor :taxable_1, :vat_1, :taxable_2, :vat_2, :taxable_3, :vat_3, :paid, :payment_date, :method_of_payment
  has_many :payments, dependent: :destroy
  belongs_to :company
  belongs_to :vehicle

  def self.payments params_id
    find(params_id).payments
  end

  def self.build payment_params, invoice_id
    company = self.payments(invoice_id)
    company.build(payment_params)
  end

  def company_name
    company.name
  end

  def company_id
    company.id
  end
end
