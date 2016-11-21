require 'rails_helper'

describe ReceiptsController, type: :controller do
  sign_in_user

  describe 'when a receipt is created' do
    let(:insurance_category) { create(:category, name: 'Assicurazioni') }
    let(:insurance) { create(:insurance) }

    before :each do
      request.env["HTTP_REFERER"] = 'where_i_came_from'
      create(:vehicle)
      insurance_category
      create(:company, name: 'Milano', category_id: insurance_category.id)
      insurance
    end

    describe 'when a receipt is valid' do
      it 'shows success message and redirects to insurance when create' do
        receipt = attributes_for(:receipt, paid: 1100)
        post :create, receipt: receipt, insurance_id: receipt[:insurance_id]
        expect(flash[:success]).to match('Ricevuta di pagamento aggiunta')
        expect(response).to redirect_to(insurance_path(id: insurance.id))
      end

      it 'shows success message and redirects to insurance when updated' do
        receipt_one = create(:receipt)
        receipt = attributes_for(:receipt, paid: 1100)
        put :update, insurance_id: receipt[:insurance_id], id: receipt_one[:id], receipt: receipt
        expect(Receipt.find(receipt_one[:id]).paid).to eq(1100)
        expect(flash[:success]).to match('Ricevuta di pagamento aggiornata')
        expect(response).to redirect_to(insurance_path(id: insurance.id))
      end
    end
  end
end
