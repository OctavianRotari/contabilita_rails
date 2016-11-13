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
    let(:insurance_company) { create(:company, name: 'Milano', category_id: insurance_category.id) }

    before :each do
      insurance_category
      insurance_company
    end

    it 'returns a collection of insurances' do
      get :company_insurances, id: insurance_company.id
      expect(response.status).to eq(200)
    end

    it 'renders page with success' do
      insurance = attributes_for(:insurance)
      post :create, insurance: insurance
      insurance = Insurance.first
      expect(response).to redirect_to(insurance_path(insurance.id))
      expect(flash[:success]).to match('Contratto assicurativo registrato')
    end

    it 'renders page with success when the insurance is divided among all vehicles' do
      insurance = attributes_for(:insurance, at_the_expense_of: 'all_vehicles')
      post :create, insurance: insurance
      insurance = Insurance.first
      expect(insurance.vehicle_id).to eq(nil)
      expect(insurance.at_the_expense_of).to eq('all_vehicles')
      expect(response).to redirect_to(insurance_path(insurance.id))
      expect(flash[:success]).to match('Contratto assicurativo registrato')
    end

    it 'renders page with success when updated' do
      insurance_create = create(:insurance)
      insurance = attributes_for(:insurance)
      put :update, id: insurance_create.id, insurance: insurance
      insurance = Insurance.first
      expect(response).to redirect_to(insurance_path(insurance.id))
      expect(flash[:success]).to match('Contratto assicurativo aggiornato')
    end
  end
end
