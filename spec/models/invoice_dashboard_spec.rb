require 'rails_helper'

describe InvoiceDashboard, type: :unit do
  let(:params) { { year: Time.zone.now.year, id: 1 } }
  let(:user) { create(:user) }
  let(:vehicle) { create(:vehicle) }
  let(:category) { create(:category) }
  let(:company) { create(:company) }
  let(:active_invoice) { create(:invoice) }
  let(:passive_invoice) { create(:passive_invoice) }
  let(:invoice_dashboard) { InvoiceDashboard.new(user, params) }

  before :each do
    user
    vehicle
    category
    company
    active_invoice
    passive_invoice
  end

  describe '#invoices' do
    it 'returns all the invoices' do
      expect(invoice_dashboard.invoices).to eq([passive_invoice, active_invoice])
    end
  end

  describe 'year_invoices' do
    it 'returns all passive invoices' do
      expect(invoice_dashboard.year_passive).to eq([passive_invoice])
    end

    it 'returns all active invoices' do
      expect(invoice_dashboard.year_active).to eq([active_invoice])
    end
  end

  describe 'general_expences_invoices' do
    it 'returns all passive invoices' do
      invoice = create(:general_expenses_invoice)
      expect(invoice_dashboard.general_expenses_passive).to eq([invoice])
    end

    it 'returns all active invoices' do
      invoice = create(:general_expenses_invoice, type_of_invoice: 'attiva')
      expect(invoice_dashboard.general_expenses_active).to eq([invoice])
    end
  end

  describe 'company_invoices' do
    it 'returns all passive invoices' do
      expect(invoice_dashboard.company_passive).to eq([passive_invoice])
    end

    it 'returns all active invoices' do
      expect(invoice_dashboard.company_active).to eq([active_invoice])
    end
  end

  describe 'vehicle_invoices' do
    it 'returns all passive invoices' do
      expect(invoice_dashboard.vehicle_passive).to eq([passive_invoice])
    end

    it 'returns all active invoices' do
      expect(invoice_dashboard.vehicle_active).to eq([active_invoice])
    end
  end

  describe 'category_invoices' do
    it 'returns all passive invoices' do
      expect(invoice_dashboard.category_passive).to eq([passive_invoice])
    end

    it 'returns all active invoices' do
      expect(invoice_dashboard.category_active).to eq([active_invoice])
    end
  end
end
