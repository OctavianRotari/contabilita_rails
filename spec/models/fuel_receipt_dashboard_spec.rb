require 'rails_helper'

describe FuelReceiptDashboard, type: :unit do
  let(:current_user) { create(:user) }
  let(:id) { id = 1 }
  let(:fuel_receipt_dashboard) { FuelReceiptDashboard.new(id, current_user) }

  before :each do
    fuel_receipt_dashboard
  end

  describe '#gas_station_companies' do
    it 'return only companies that are gas companies' do
      create(:gas_station_category)
      gas_company = create(:company)
      expect(fuel_receipt_dashboard.gas_station_companies).to eq([gas_company])
    end

    it 'does not return companies that are not gas companies' do
      category = create(:category)
      create(:company, category_id: category.id)
      expect(fuel_receipt_dashboard.gas_station_companies).to eq([])
    end
  end

  describe '#company' do
    it 'returns the company with the id present in params' do
      create(:category)
      company = create(:company)
      expect(fuel_receipt_dashboard.company).to eq(company)
    end
  end

  describe '#vehicle' do
    it 'returns the vehicle with the id present in params' do
      vehicle = create(:vehicle)
      expect(fuel_receipt_dashboard.vehicle).to eq(vehicle)
    end
  end

  describe '#current_user_companies' do
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

  describe '#current_user_categories' do
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

  describe '#current_user_vehicles' do
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
