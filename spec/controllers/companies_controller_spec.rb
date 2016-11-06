require 'rails_helper'

describe CompaniesController, type: :controller do
  sign_in_user

  before :each do
    create(:category)
  end

  describe 'when an company is valid' do
    let(:company) { attributes_for(:company) }

    it 'shows success message and redirects to company' do
      post :create, company: company
      expect(flash[:success]).to match('Azienda aggiunta')
      expect(response).to redirect_to(dashboard_companies_path)
    end
  end

  describe 'when company is deleted' do
    before(:each) do
      request.env["HTTP_REFERER"] = 'where_i_came_from'
    end

    it 'renders page with success and redirects to dashboard' do
      create(:company)
      delete :destroy, id: 1
      expect(flash[:success]).to match('Azienda elliminata')
      expect(response).to redirect_to(dashboard_invoices_path)
    end

    it 'renders page with success and redirects :back' do
      create(:company)
      create(:company)
      delete :destroy, id: 1
      expect(flash[:success]).to match('Azienda elliminata')
      expect(response).to redirect_to('where_i_came_from')
    end
  end
end
