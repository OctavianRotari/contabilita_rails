require 'spec_helper'

describe InvoiceTotalsHelper, type: :unit do
  let(:extended_class) { Class.new { extend InvoiceTotalsHelper } }

  before :each do
    create_vehicle
    company = company('Octav')
    company_1 = company('Rotari')
    invoice = create_record(company)
    add_payment_to_invoice(invoice)
    create_record(company_1)
  end

  describe '#total_all_invoices' do
    it 'should calculate the total of all invoices' do
      expect(extended_class.total_all_invoices).to eq(220)
    end
  end

  describe '#total_vat_all_invoices' do
    it 'should calculate the total vat of all invoices' do
      expect(extended_class.total_vat_all_invoices).to eq(20)
    end
  end

  describe '#paid_per_invoice' do
    it 'should calculate the total paid for a specific invoice' do
      expect(extended_class.paid_per_invoice(1)).to eq(60)
    end
  end

  describe '#total_paid_all_invoice' do
    it 'should calculate the total paid for all invoice' do
      expect(extended_class.total_paid_all_invoices).to eq(60)
    end
  end

  describe '#to_pay_per_invoice' do
    it 'should calculate the total to pay per invoice' do
      expect(extended_class.to_pay_per_invoice(1)).to eq(50)
    end
  end

  describe '#total_to_pay_all_invoices' do
    it 'should calculate the total to pay for all invoices' do
      expect(extended_class.total_to_pay_all_invoices).to eq(160)
    end
  end
end
