class Invoice < ActiveRecord::Base
  attr_accessor :taxable_1, :vat_1, :taxable_2, :vat_2, :taxable_3, :vat_3
  has_many :payments
  belongs_to :company

  def self.by_company params_id
    Company.invoices params_id
  end

  def self.calculate_total invoice_params
    (BuildInvoice.new invoice_params).total
  end

  def self.add_to_company invoice, company_id
    (Company.invoices(company_id)).build(invoice)
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
