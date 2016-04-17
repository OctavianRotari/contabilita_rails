class Invoice < ActiveRecord::Base
  attr_accessor :taxable_1, :vat_1, :taxable_2, :vat_2, :taxable_3, :vat_3, :paid, :method_of_payment
  has_many :payments, dependent: :destroy
  belongs_to :company

  def self.by_company params_id
    Company.invoices params_id
  end

  def self.register params
    invoice = BuildInvoice.new params
    invoice.build
  end

  def self.payments params_id
    find(params_id).payments
  end

  def company_name
    company.name
  end

  def company_id
    company.id
  end
end
