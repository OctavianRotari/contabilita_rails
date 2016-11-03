require 'rails_helper'

describe PaymentsController, type: :controller do
  sign_in_user

  describe 'when a payment is created' do
    before :each do
      create(:vehicle)
      create(:category)
      create(:company)
      create(:invoice, type_of_invoice: 'passiva')
    end

    it 'updates paid in the corresponding invoice' do
      payment = attributes_for(:payment, paid: 110)
      post :create, payment: payment, invoice_id: payment[:invoice_id]
      expect(Invoice.first.paid).to eq(true)
    end
  end
end
