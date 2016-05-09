class Invoice < ActiveRecord::Base
  attr_accessor :taxable_1, :vat_1, :taxable_2, :vat_2, :taxable_3, :vat_3, :paid, :payment_date, :method_of_payment
  has_many :payments, dependent: :destroy
  belongs_to :company
  belongs_to :vehicle

  def self.by_company params_id
    Company.invoices params_id
  end

  def self.build(invoice_params)
    params = BuildInvoice.new(invoice_params)
    params.build
  end

  def self.add_to_parents(company_id, invoice)
    company_invoice = Company.build invoice, company_id
    vehicle_invoice = Vehicle.build invoice, invoice[:vehicle_id]
    company_invoice
  end

  def self.payments params_id
    find(params_id).payments
  end

  def self.total
    invoices = Invoice.all
    total = 0
    invoices.each do |invoice|
      total += invoice.total
    end
    total
  end

  def self.total_vat
    invoices = Invoice.all
    total = 0
    invoices.each do |invoice|
      total += invoice.vat
    end
    total
  end

  def self.paid(id)
    invoice = Invoice.find(id)
    total = 0
    invoice.payments.each do |payment|
      total += payment.paid
    end
    total
  end

  def self.total_paid
    invoices = Invoice.all
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    total
  end

  def self.to_pay(id)
    invoice = Invoice.find(id)
    total = 0
    invoice.payments.each do |payment|
      total += payment.paid
    end
    invoice.total - total
  end

  def self.total_to_pay
    invoices = Invoice.all
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    self.total - total
  end

  def company_name
    company.name
  end

  def company_id
    company.id
  end
end
