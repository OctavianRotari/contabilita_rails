require 'rails_helper'
feature 'current_user' do
  let(:other_user) { create(:user) }
  let(:current_user) { create(:user, email: 'octavianrotari@test.com') }

  before :each do
    current_user
    create(:vehicle, user_id: other_user.id)
    create(:category, user_id: other_user.id)
    create(:company, user_id: other_user.id)
    create(:invoice, user_id: other_user.id)
    create(:fuel_receipt, user_id: other_user.id)
    sign_in
  end

  feature 'current_user doesnt see' do
    scenario 'vehicles of other user' do
      expect(current_user.vehicles).to eq([])
    end

    scenario 'categories of other user' do
      expect(current_user.categories).to eq([])
    end

    scenario 'companies of other user' do
      expect(current_user.companies).to eq([])
    end

    scenario 'invoices of other user' do
      expect(current_user.invoices).to eq([])
    end

    scenario 'fuel receipts of other user' do
      expect(current_user.fuel_receipts).to eq([])
    end
  end
end
