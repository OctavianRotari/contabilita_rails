require 'rails_helper'

describe VehicleDashboard, type: :unit do
  let(:time_now) { Time.zone.now }
  let(:params) { {month: time_now.month, year: time_now.year, id: 1 } }
  let(:vehicle) { create(:vehicle) }
  let(:current_user) { create(:user) }
  let(:vehicle_dashboard) { VehicleDashboard.new(current_user, params) }

  before :each do
    current_user
    vehicle
  end

  describe '#plate' do
    it 'it returns the plate of the vehicle' do
      expect(vehicle_dashboard.plate).to eq('ER354BS')
    end
  end

  describe '#invoices' do
    it 'returns all the invoices registered on this vehicle' do
      create(:category)
      create(:company)
      invoice = create(:invoice, type_of_invoice: 'passiva')
      expect(vehicle_dashboard.invoices).to eq([invoice])
    end
  end
end
