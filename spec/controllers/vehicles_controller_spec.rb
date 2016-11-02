require 'rails_helper'

describe VehiclesController, type: :controller do
  sign_in_user

  describe 'when a vehicle is valid' do
    it 'renders page with success' do
      vehicle = attributes_for(:vehicle)
      post :create, vehicle: { plate: vehicle[:plate], type_of_vehicle: vehicle[:type_of_vehicle]}
      expect(response).to redirect_to(dashboard_vehicles_path)
      expect(flash[:success]).to match('Mezzo aggiunto')
    end
  end

  describe 'when a vehicle is invalid' do
    it 'renders the page with error' do
      vehicle = attributes_for(:vehicle)
      post :create, vehicle: { plate: vehicle[:plate], type_of_vehicle: nil }
      expect(response).to render_template(:new)
      expect(flash[:error]).to match('Mezzo non aggiunto')
    end
  end

  describe 'when a vehicle is destroyed' do
    it 'renders page with success' do
      create(:vehicle)
      delete :destroy, id: 1
      expect(flash[:success]).to match('Mezzo elliminato')
    end
  end
end
