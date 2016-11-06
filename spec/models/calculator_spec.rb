require 'rails_helper'

require 'spec_helper'

describe Calculator, type: :unit do
  let(:calculator) { Calculator.new }
  let(:invoice) { create(:invoice, type_of_invoice: 'passiva') }

  before :each do
    create(:user)
    create(:category)
    create(:vehicle)
    create(:company)
    create(:invoice)
    invoice
  end

  describe '#total_all_invoices' do
    it 'should calculate the total of all invoices' do
      invoices = Invoice.all
      expect(calculator.total_all(invoices)).to eq(220)
    end
  end

  describe '#total_vat_all_invoices' do
    it 'should calculate the total vat of all invoices' do
      invoices = Invoice.all
      expect(calculator.total_vat_all(invoices)).to eq(20)
    end
  end

  describe '#total_paid_or_collected_all' do
    it 'should calculate the total collected active invoices' do
      create(:payment)
      invoices = Invoice.active
      expect(calculator.total_paid_or_collected_all(invoices)).to eq(100)
    end

    it 'should calculate the total collected passive invoices' do
      create(:payment, invoice_id: invoice.id)
      invoices = Invoice.passive
      expect(calculator.total_paid_or_collected_all(invoices)).to eq(100)
    end
  end

  describe '#total_remaining_all' do
    it 'should calculate the total that remains to collect for active invoices' do
      create(:invoice)
      create(:payment)
      invoices = Invoice.active
      expect(calculator.total_remaining_all(invoices)).to eq(120)
    end

    it 'should calculate the total that remains to pay for passive invoices' do
      create(:invoice, type_of_invoice: 'passiva')
      create(:payment, invoice_id: invoice.id)
      invoices = Invoice.passive
      expect(calculator.total_remaining_all(invoices)).to eq(120)
    end
  end

  describe '#to_pay_per' do
    it 'should calculate the total that remains to pay per invoice' do
      create(:payment, invoice_id: invoice.id)
      expect(calculator.to_pay_per(invoice)).to eq(10)
    end
  end

  describe '#total_costs_current_month' do
    let(:invoices) { Invoice.passive }

    before :each do
      invoice
    end

    it 'should calculate the total costs per month' do
      expect(calculator.total_costs_current_month(invoices)).to eq(110)
    end

    it 'should not consider invoice if from different month' do
      create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.month)
      expect(calculator.total_costs_current_month(invoices)).to eq(110)
    end
  end

  describe '#total_costs_current_year' do
    let(:invoices) { Invoice.passive }

    before :each do
      invoice
      create(:invoice, type_of_invoice: 'passiva')
    end

    it 'should calculate the total costs per month' do
      expect(calculator.total_costs_current_year(invoices)).to eq(220)
    end

    it 'should not consider invoice if from different month' do
      create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.year)
      expect(calculator.total_costs_current_year(invoices)).to eq(220)
    end
  end

  describe '#total_costs_month_garage_divided' do
    let(:invoices) { Invoice.passive }

    before :each do
      invoice
      create(:invoice, type_of_invoice: 'passiva')
      create(:vehicle)
    end

    it 'should calculate the total costs per month' do
      expect(calculator.total_costs_month_garage_divided(invoices)).to eq(110)
    end

    it 'should not consider invoice if from different month' do
      create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.month)
      expect(calculator.total_costs_month_garage_divided(invoices)).to eq(110)
    end
  end

  describe '#total_costs_year_garage_divided' do
    let(:invoices) { Invoice.passive }

    before :each do
      invoice
      create(:invoice, type_of_invoice: 'passiva')
      create(:vehicle)
    end

    it 'should calculate the total costs per month' do
      expect(calculator.total_costs_year_garage_divided(invoices)).to eq(110)
    end

    it 'should not consider invoice if from different month' do
      create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.year)
      expect(calculator.total_costs_year_garage_divided(invoices)).to eq(110)
    end
  end

  describe '#total_fuel_receipts_current_month' do
    let(:fuel_receipts) { FuelReceipt.all }

    before :each do
      create(:fuel_receipt)
      create(:fuel_receipt)
    end

    it 'should calculate the total costs per month' do
      expect(calculator.total_fuel_receipts_current_month(fuel_receipts)).to eq(600)
    end

    it 'should not consider invoice if from different month' do
      create(:fuel_receipt, date_of_issue: Time.zone.now - 1.month)
      expect(calculator.total_fuel_receipts_current_month(fuel_receipts)).to eq(600)
    end
  end

  describe '#total_fuel_receipts_current_year' do
    let(:fuel_receipts) { FuelReceipt.all }

    before :each do
      create(:fuel_receipt)
      create(:fuel_receipt)
    end

    it 'should calculate the total costs per month' do
      expect(calculator.total_fuel_receipts_current_year(fuel_receipts)).to eq(600)
    end

    it 'should not consider invoice if from different month' do
      create(:fuel_receipt, date_of_issue: Time.zone.now - 1.year)
      expect(calculator.total_fuel_receipts_current_year(fuel_receipts)).to eq(600)
    end
  end
end
