require 'rails_helper'

describe CategoriesController, type: :controller do
  sign_in_user

  describe 'when an category is valid' do
    let(:category) { attributes_for(:category) }

    it 'shows success message and redirects to category' do
      post :create, category: category
      expect(flash[:success]).to match('Categoria aggiunta')
      expect(response).to redirect_to(dashboard_categories_path)
    end
  end

  describe 'when category is deleted' do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it 'renders page with success and redirects to dashboard' do
      create(:category)
      delete :destroy, id: 1
      expect(flash[:success]).to match('Categoria elliminata')
      expect(response).to redirect_to(dashboard_invoices_path)
    end

    it 'renders page with success and redirects :back' do
      create(:category)
      create(:category)
      delete :destroy, id: 1
      expect(flash[:success]).to match('Categoria elliminata')
      expect(response).to redirect_to("where_i_came_from")
    end
  end
end
