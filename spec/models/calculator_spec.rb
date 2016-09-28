require 'rails_helper'

require 'spec_helper'

describe Calculator, type: :unit do

  before :each do
    @calculator = Calculator.new
    create_category
    create_vehicle
    company = company('Octav')
    company_1 = company('Rotari')
    invoice = create_passive_record(company)
    add_payment_to_invoice(invoice)
    create_passive_record(company_1)
  end

  describe '#total_all_invoices' do
    it 'should calculate the total of all invoices' do
      invoices = Invoice.all
      expect(@calculator.total_all(invoices)).to eq(220)
    end
  end

  describe '#total_vat_all_invoices' do
    it 'should calculate the total vat of all invoices' do
      invoices = Invoice.all
      expect(@calculator.total_vat_all(invoices)).to eq(20)
    end
  end

  describe '#paid_per_invoice' do
    it 'should calculate the total paid for a specific invoice' do
      invoice = Invoice.first
      expect(@calculator.paid_per(invoice)).to eq(60)
    end
  end

  describe '#total_paid_all_invoice' do
    it 'should calculate the total paid for all invoice' do
      invoices = Invoice.all
      expect(@calculator.total_paid_or_collected_all(invoices)).to eq(60)
    end
  end

  describe '#to_pay_per_invoice' do
    it 'should calculate the total to pay per invoice' do
      invoice = Invoice.first
      expect(@calculator.to_pay_per(invoice)).to eq(50)
    end
  end

  describe '#total_to_pay_all_invoices' do
    it 'should calculate the total to pay for all invoices' do
      invoices = Invoice.all
      expect(@calculator.total_remaining_all(invoices)).to eq(160)
    end
  end
end
