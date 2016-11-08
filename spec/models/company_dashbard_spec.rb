require 'rails_helper'

describe CompanyDashboard, type: :unit do
  let(:company) { create(:company) }
  let(:id) { 1 }
  let(:current_user) { create(:user) }
  let(:company_dashboard) { CompanyDashboard.new(id, current_user) }

  before :each do
    current_user
    create(:category)
    create(:vehicle)
    company
  end

  describe '#name' do
    it 'it returns the plate of the vehicle' do
      expect(company_dashboard.company_name).to eq('Esso')
    end
  end

  describe '#invoices' do
    it 'returns all the invoices registered on this vehicle' do
      invoice = create(:invoice, type_of_invoice: 'passiva')
      expect(company_dashboard.invoices).to eq([invoice])
    end
  end

  describe '#companies' do
    it 'returns all the invoices registered on this vehicle' do
      expect(company_dashboard.companies).to eq([company])
    end
  end
end
