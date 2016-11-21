require 'rails_helper'

describe FuelReceiptDashboard, type: :unit do
  let(:current_user) { create(:user) }
  let(:time_now) { Time.zone.now }
  let(:params) { {month: time_now.month, year: time_now.year, id: 1 } }
  let(:fuel_receipt) { create(:fuel_receipt) }
  let(:gas_station_category) { create(:gas_station_category) }
  let(:gas_station_company) { create(:company) }
  let(:vehicle) { create(:vehicle) }
  let(:fuel_receipt_dashboard) { FuelReceiptDashboard.new(params, current_user) }

  describe 'Fuel receipts dashboard' do
    before :each do
      current_user
      vehicle
      gas_station_category
      gas_station_company
      fuel_receipt_dashboard
    end

    describe '#gas_station_companies' do
      it 'return only companies that are gas companies' do
        expect(fuel_receipt_dashboard.gas_station_companies).to eq([gas_station_company])
      end

      it 'does not return companies that are not gas companies' do
        category = create(:category)
        create(:company, category_id: category.id)
        expect(fuel_receipt_dashboard.gas_station_companies).to eq([gas_station_company])
      end
    end

    describe '#company' do
      it 'returns the company with the id present in params' do
        expect(fuel_receipt_dashboard.company).to eq(gas_station_company)
      end
    end

    describe '#vehicle' do
      it 'returns the vehicle with the id present in params' do
        expect(fuel_receipt_dashboard.vehicle).to eq(vehicle)
      end
    end

    describe '#vehicle_fuel_receipts' do
      it 'returns all the fuel receipts for the current year' do
        expect(fuel_receipt_dashboard.vehicle_fuel_receipts_month).to eq([fuel_receipt])
      end

      it 'returns fuel receipt from the month indicated in params' do
        one_month_ago = Time.new(time_now.year, time_now.month - 1)
        params = { month: one_month_ago.month, year: time_now.year, id: 1 }
        fuel_receipt_dashboard = FuelReceiptDashboard.new(params, current_user)
        fuel_receipt = create(:fuel_receipt, date_of_issue: Time.zone.now - 1.month)
        expect(fuel_receipt_dashboard.vehicle_fuel_receipts_month).to eq([fuel_receipt])
      end
    end

    describe '#company_fuel_receipts' do
      it 'returns all the fuel receipts for the current year' do
        expect(fuel_receipt_dashboard.company_fuel_receipts_month).to eq([fuel_receipt])
      end

      it 'returns fuel receipt from the month indicated in params' do
        one_month_ago = Time.new(time_now.year, time_now.month - 1)
        params = { month: one_month_ago.month, year: time_now.year, id: 1 }
        fuel_receipt_dashboard = FuelReceiptDashboard.new(params, current_user)
        fuel_receipt = create(:fuel_receipt, date_of_issue: Time.zone.now - 1.month)
        expect(fuel_receipt_dashboard.company_fuel_receipts_month).to eq([fuel_receipt])
      end
    end
  end

  describe 'current user records module' do
    before :each do
      current_user
    end

    describe '#current_user_companies module' do
      let(:category) { create(:category) }
      let(:company) { create(:company, category_id: category.id) }

      before :each do
        category
        company
      end

      it 'shows all the companies for the current user' do
        expect(fuel_receipt_dashboard.current_user_companies).to eq([company])
      end

      it 'does not show companies created on other users' do
        other_user = create(:user, email: 'test@test.com')
        category = create(:category, user_id: other_user.id)
        create(:company, category_id: category.id, user_id: other_user.id)
        expect(fuel_receipt_dashboard.current_user_companies).to eq([company])
      end
    end

    describe '#current_user_categories module' do
      let(:category) { create(:category) }

      before :each do
        category
      end

      it 'shows all the companies for the current user' do
        expect(fuel_receipt_dashboard.current_user_categories).to eq([category])
      end

      it 'does not show companies created on other users' do
        other_user = create(:user, email: 'test@test.com')
        create(:category, user_id: other_user.id)
        expect(fuel_receipt_dashboard.current_user_categories).to eq([category])
      end
    end

    describe '#current_user_vehicles module' do
      let(:vehicle) { create(:vehicle) }

      before :each do
        vehicle
      end

      it 'shows all the companies for the current user' do
        expect(fuel_receipt_dashboard.current_user_vehicles).to eq([vehicle])
      end

      it 'does not show companies created on other users' do
        other_user = create(:user, email: 'test@test.com')
        create(:vehicle, user_id: other_user.id)
        expect(fuel_receipt_dashboard.current_user_vehicles).to eq([vehicle])
      end
    end
  end
end
