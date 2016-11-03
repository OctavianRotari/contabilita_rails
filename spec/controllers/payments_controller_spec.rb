require 'rails_helper'

describe PaymentsController, type: :controller do
  sign_in_user

  describe 'when a payment is created' do
    let(:invoice) { create(:invoice, type_of_invoice: 'passiva') }

    before :each do
      create(:vehicle)
      create(:category)
      create(:company)
      invoice
    end

    describe 'when a payment is valid' do
      it 'updates paid in the corresponding invoice' do
        payment = attributes_for(:payment, paid: 110)
        post :create, payment: payment, invoice_id: payment[:invoice_id]
        expect(Invoice.first.paid).to eq(true)
      end

      it 'shows success message and redirects to invoice' do
        payment = attributes_for(:payment, paid: 110)
        post :create, payment: payment, invoice_id: payment[:invoice_id]
        expect(flash[:success]).to match('Pagamento aggiunto')
        expect(response).to redirect_to(invoice_path(id: invoice.id))
      end
    end

    describe 'when payment is deleted' do
      it 'renders page with success' do
        create(:payment)
        delete :destroy, id: 1, invoice_id: invoice.id
        expect(flash[:success]).to match('Pagamento elliminata')
      end
    end
  end
end
