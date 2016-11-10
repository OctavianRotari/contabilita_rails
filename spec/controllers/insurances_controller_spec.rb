require 'rails_helper'

describe InsurancesController, type: :controller do
  sign_in_user

  let(:insurance_category) { create(:insurance_category) }

  before :each do
    create(:vehicle)
    request.env["HTTP_REFERER"] = 'where_i_came_from'
  end

  describe 'before each action' do
    it 'checks if an insurance category exists' do
      get :new
      expect(flash[:error]).to match('Aggiungere una categoria che indichi le assicurazioni')
    end

    it 'checks if an insurance company exists' do
      insurance_category
      get :new
      expect(flash[:error]).to match('Aggiungere almeno una compania assicurativa')
    end
  end

  describe 'when an insurance is valid' do
    before :each do
      insurance_category
      create(:company, name: 'Milano', category_id: insurance_category.id)
    end

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
