require 'rails_helper'

describe FuelReceiptDashboard, type: :unit do
  before :each do
    current_user = create(:user)
    params = { 'controller' => 'fuel_receipts', 'action' => 'new', id: 1 }
    @fuel_receipt_dashboard = FuelReceiptDashboard.new(params, current_user)
  end

  describe '#gas_station_companies' do
    it 'return only companies that are gas companies' do
      create(:category)
      gas_company = create(:company)
      expect(@fuel_receipt_dashboard.gas_station_companies).to eq([gas_company])
    end

    it 'does not return companies that are not gas companies' do
      category = create(:category)
      company = create(:company, category_id: category.id)
      expect(@fuel_receipt_dashboard.gas_station_companies).to eq([company])
    end
  end

  describe '#company' do
    it 'returns the company with the id present in params' do
      create(:category)
      company = create(:company)
      expect(@fuel_receipt_dashboard.company).to eq(company)
    end
  end

  describe '#vehicle' do
    it 'returns the vehicle with the id present in params' do
      vehicle = create(:vehicle)
      expect(@fuel_receipt_dashboard.vehicle).to eq(vehicle)
    end
  end

  describe '#current_user_companies' do
    before :each do
      category = create(:category)
      @company = create(:company, category_id: category.id)
    end

    it 'shows all the companies for the current user' do
      expect(@fuel_receipt_dashboard.current_user_companies).to eq([@company])
    end

    it 'does not show companies created on other users' do
      other_user = create(:user, email: 'test@test.com')
      category = create(:category, user_id: other_user.id)
      create(:company, category_id: category.id, user_id: other_user.id)
      expect(@fuel_receipt_dashboard.current_user_companies).to eq([@company])
    end
  end

  describe '#current_user_categories' do
    before :each do
      @category = create(:category)
    end

    it 'shows all the companies for the current user' do
      expect(@fuel_receipt_dashboard.current_user_categories).to eq([@category])
    end

    it 'does not show companies created on other users' do
      other_user = create(:user, email: 'test@test.com')
      create(:category, user_id: other_user.id)
      expect(@fuel_receipt_dashboard.current_user_categories).to eq([@category])
    end
  end

  describe '#current_user_vehicles' do
    before :each do
      @vehicle = create(:vehicle)
    end

    it 'shows all the companies for the current user' do
      expect(@fuel_receipt_dashboard.current_user_vehicles).to eq([@vehicle])
    end

    it 'does not show companies created on other users' do
      other_user = create(:user, email: 'test@test.com')
      create(:vehicle, user_id: other_user.id)
      expect(@fuel_receipt_dashboard.current_user_vehicles).to eq([@vehicle])
    end
  end
end
