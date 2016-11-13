require 'rails_helper'

describe InvoiceDashboard, type: :unit do
  let(:params) { {} }
  let(:user) { create(:user) }
  let(:vehicle) { create(:vehicle) }
  let(:category) { create(:category) }
  let(:company) { create(:company) }
  let(:invoice) { create(:invoice) }

  before :each do
    user
    vehicle
    category
    company
    invoice
  end

  describe '#invoices' do
    it 'returns all the invoices' do
      invoice_dashboard = InvoiceDashboard.new(user, params)
      expect(invoice_dashboard.invoices).to eq([invoice])
    end
  end

  describe '#general_expences_invoices' do
    it 'returns all the invoices' do
      invoice = create(:general_expenses_invoice)
      invoice_dashboard = InvoiceDashboard.new(user, params)
      expect(invoice_dashboard.general_expenses_invoices).to eq([invoice])
    end
  end

  describe '#company_invoices' do
    it 'returns all the invoices' do
      invoice_dashboard = InvoiceDashboard.new(user, company)
      expect(invoice_dashboard.company_invoices).to eq([invoice])
    end
  end

  describe '#vehicle_invoices' do
    it 'returns all the invoices' do
      invoice_dashboard = InvoiceDashboard.new(user, vehicle)
      expect(invoice_dashboard.vehicle_invoices).to eq([invoice])
    end
  end

  describe '#category_invoices' do
    it 'returns all the invoices' do
      invoice_dashboard = InvoiceDashboard.new(user, category)
      expect(invoice_dashboard.category_invoices).to eq([invoice])
    end
  end
end
