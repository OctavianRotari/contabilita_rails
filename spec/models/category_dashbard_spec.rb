require 'rails_helper'

describe CategoryDashboard, type: :unit do
  let(:category) { create(:category) }
  let(:id) { 1 }
  let(:current_user) { create(:user) }
  let(:category_dashboard) { CategoryDashboard.new(id, current_user) }

  before :each do
    current_user
    category
    create(:company)
    create(:vehicle)
  end

  describe '#category_name' do
    it 'it returns the plate of the vehicle' do
      expect(category_dashboard.category_name).to eq('Benzinaio')
    end
  end

  describe '#invoices' do
    it 'returns all the invoices registered on this vehicle' do
      invoice = create(:invoice, type_of_invoice: 'passiva')
      expect(category_dashboard.invoices).to eq([invoice])
    end
  end

  describe '#categories' do
    it 'returns all the invoices registered on this vehicle' do
      expect(category_dashboard.categories).to eq([category])
    end
  end
end
