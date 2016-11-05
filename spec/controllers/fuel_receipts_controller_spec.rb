require 'rails_helper'

describe FuelReceiptsController, type: :controller do
  sign_in_user

  before :each do
    create(:vehicle)
    create(:category)
    create(:company)
  end

  describe 'when an fuel_receipt is valid' do
    let(:fuel_receipt) { attributes_for(:fuel_receipt) }

    it 'shows success message and redirects to fuel_receipt' do
      post :create, fuel_receipt: fuel_receipt
      expect(flash[:success]).to match('Scontrino aggiunto')
      expect(response).to redirect_to(fuel_receipts_path)
    end
  end

  describe 'when fuel_receipt is deleted' do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it 'renders page with success and redirects to dashboard' do
      create(:fuel_receipt)
      delete :destroy, id: 1
      expect(flash[:success]).to match('Scontrino elliminata')
      expect(response).to redirect_to(dashboard_invoices_path)
    end

    it 'renders page with success and redirects :back' do
      create(:fuel_receipt)
      create(:fuel_receipt)
      delete :destroy, id: 1
      expect(flash[:success]).to match('Scontrino elliminata')
      expect(response).to redirect_to("where_i_came_from")
    end
  end
end
