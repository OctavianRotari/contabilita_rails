require 'rails_helper'

describe InsurancesController, type: :controller do
  sign_in_user

  before :each do
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
  end
end
