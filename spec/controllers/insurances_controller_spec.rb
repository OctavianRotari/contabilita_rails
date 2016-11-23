require 'rails_helper'

describe InsurancesController, type: :controller do
  sign_in_user

  let(:insurance_category) { create(:insurance_category) }
  let(:insurance_company) { create(:company, name: 'Milano', category_id: insurance_category.id) }
  let(:vehicle) { create(:vehicle) }

  before :each do
    request.env["HTTP_REFERER"] = 'where_i_came_from'
  end

  describe 'before each action' do

    it 'checks if a vehicle exists' do
      get :new
      expect(flash[:error]).to match('Aggiungere almeno un veicolo')
    end

    describe 'after a vehicle is created' do
      before :each do
        vehicle
      end

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
  end

  describe 'when an insurance is valid' do

    before :each do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      vehicle
      insurance_category
      insurance_company
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

    describe 'update' do
      it 'renders page with success when updated' do
        insurance_create = create(:insurance)
        insurance = attributes_for(:insurance)
        put :update, id: insurance_create.id, insurance: insurance
        expect(response).to redirect_to(assigns(:insurance))
        expect(flash[:success]).to match('Contratto assicurativo aggiornato')
      end
    end

    describe 'when insurance is deleted' do
      it 'renders page with success and redirects to dashboard' do
        create(:insurance)
        delete :destroy, id: 1
        expect(flash[:success]).to match('Contratto assicurativo elliminato')
        expect(response).to redirect_to(dashboard_invoices_path)
      end

      it 'renders page with success and redirects :back' do
        create(:insurance)
        create(:insurance)
        delete :destroy, id: 1
        expect(flash[:success]).to match('Contratto assicurativo elliminato')
        expect(response).to redirect_to("where_i_came_from")
      end
    end
  end
end
