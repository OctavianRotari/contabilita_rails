require 'rails_helper'

describe InvoicesController, type: :controller do
  sign_in_user

  before :each do
    create(:vehicle)
    create(:category)
    create(:company)
  end

  describe 'when an invoice is valid' do
    let(:invoice_params) { attributes_for(:invoice_params) }

    it 'calculates total vat total and total taxable' do
      post :create, invoice: invoice_params
      expect(Invoice.first.total).to eq(110)
      expect(Invoice.first.total_vat).to eq(10)
      expect(Invoice.first.total_taxable).to eq(100)
    end
  end
end
