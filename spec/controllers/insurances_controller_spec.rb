require 'rails_helper'

describe InsurancesController, type: :controller do
  sign_in_user

  before :each do
    create(:vehicle)
    insurance_category = create(:category, name: 'Assicurazioni')
    create(:company, name: 'Milano', category_id: insurance_category.id)
  end

  describe 'when an insurance is valid' do
    it 'renders page with success' do
      insurance = attributes_for(:insurance)
      post :create, insurance: insurance
      insurance = Insurance.first
      expect(response).to redirect_to(insurance_path(insurance.id))
      expect(flash[:success]).to match('Contratto assicurativo registrato')
    end

    it 'renders page with success when the insurance is divided among all vehicles' do
      insurance = attributes_for(:insurance, vehicle_id: 'all_vehicles')
      post :create, insurance: insurance
      insurance = Insurance.first
      expect(insurance.vehicle_id).to eq(nil)
      expect(insurance.at_the_expense_of).to eq('Tutti i mezzi')
      expect(response).to redirect_to(insurance_path(insurance.id))
      expect(flash[:success]).to match('Contratto assicurativo registrato')
    end
  end
end
