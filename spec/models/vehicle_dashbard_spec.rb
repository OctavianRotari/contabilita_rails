require 'rails_helper'

describe VehicleDashboard, type: :unit do
  before :each do
    current_user = create(:user)
    id = 1
    @vehicle_dashboard = VehicleDashboard.new(id, current_user)
    create(:vehicle)
  end

  describe '#plate' do
    it 'it returns the plate of the vehicle' do
      expect(@vehicle_dashboard.plate).to eq('ER354BS')
    end
  end

  describe '#invoices' do
    it 'returns all the invoices registered on this vehicle' do
      create(:category)
      create(:company)
      invoice = create(:invoice, type_of_invoice: 'passiva')
      expect(@vehicle_dashboard.invoices).to eq([invoice])
    end
  end
end
