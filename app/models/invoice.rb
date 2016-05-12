class Invoice < ActiveRecord::Base
  attr_accessor :taxable_vat_fields_attributes
  has_many :payments, dependent: :destroy
  has_many :taxable_vat_fields
  belongs_to :company
  belongs_to :vehicle
  accepts_nested_attributes_for :taxable_vat_fields

  def self.payments params_id
    find(params_id).payments
  end

  def self.active
    where(type_of_invoice: 'attiva')
  end

  def self.passive
    where(type_of_invoice: 'passiva')
  end

  def self.build(payment_params, invoice_id)
    invoice = Invoice.find(invoice_id)
    invoice.payments.build(payment_params)
  end

  def company_name
    company.name
  end

end
