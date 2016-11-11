require 'rails_helper'

describe Vehicle, type: :unit do
  let(:user) { create(:user) }

  before :each do
    user
  end

  describe 'vehicle should not be created ' do
    it 'if fields are empty' do
      vehicle = build(:vehicle, plate: '', type_of_vehicle: '')
      vehicle.save
      expect(vehicle.errors.count).to eq(2)
      expect(user.vehicles).to eq([])
    end
  end

  describe '#invoices' do
    let(:company) { create(:company) }
    let(:vehicle) { create(:vehicle) }
    let(:second_company) { create(:company) }

    before :each do
      create(:category)
      vehicle
      company
    end

    describe '#charge_general_expences' do
      it 'should return only vehicles that will be charged of general expences' do
        vehicle_expences = create(:vehicle, charge_general_expences: true)
        expect(Vehicle.charge_general_expences).to eq([vehicle_expences])
        expect(Vehicle.charge_general_expences).not_to include(vehicle)
      end
    end

    describe '#receipts' do
      it 'should have many receipts' do
        fuel_receipt = create(:fuel_receipt)
        fuel_receipt_2 = create(:fuel_receipt)
        expect(vehicle.fuel_receipts).to eq([fuel_receipt_2, fuel_receipt])
      end

      it "should return all the vehicle's fuel receipts with a given company_id" do
        fuel_receipt = create(:fuel_receipt)
        expect(vehicle.fuel_receipts_per_company(company.id)).to eq([fuel_receipt])
      end

      it 'should not return fuel receipts with other ids' do
        create(:fuel_receipt, company_id: second_company.id)
        expect(vehicle.fuel_receipts_per_company(company.id)).to eq([])
      end
    end
  end
end
