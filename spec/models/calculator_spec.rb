require 'rails_helper'

describe Calculator, type: :unit do
  let(:user) { create(:user) }
  let(:calculator) { Calculator.new }
  let(:invoice) { create(:invoice, type_of_invoice: 'passiva') }
  let(:vehicle) { create(:vehicle) }

  before :each do
    user
    create(:category)
    vehicle
    create(:company)
    create(:invoice)
    invoice
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

  describe '#total_costs_month_general_expences_divided' do
    let(:invoices) { Invoice.passive }

    before :each do
      invoice
      create(:general_expenses_invoice)
      create(:vehicle, charge_general_expenses: true)
      create(:vehicle, charge_general_expenses: true)
    end

    it 'should calculate the total costs per month' do
      expect(calculator.total_general_expenses_month(invoices, user)).to eq(110)
    end

    it 'should not consider invoice if from different month' do
      create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.month)
      expect(calculator.total_general_expenses_month(invoices, user)).to eq(110)
    end
  end

  describe '#total_costs_year_general_expences_divided' do
    let(:invoices) { Invoice.passive }

    before :each do
      invoice
      create(:general_expenses_invoice)
      create(:vehicle, charge_general_expenses: true)
      create(:vehicle, charge_general_expenses: true)
    end

    it 'should calculate the total costs per month' do
      expect(calculator.total_general_expenses_year(invoices, user)).to eq(110)
    end

    it 'should not consider invoice if from different month' do
      create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.year)
      expect(calculator.total_general_expenses_year(invoices, user)).to eq(110)
    end
  end
end
