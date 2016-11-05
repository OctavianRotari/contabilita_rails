require 'rails_helper'

describe PaymentDashboard, type: :unit do
  let(:payment_params) { create(:payment, paid: 110) }
  let(:payment_dashboard) { PaymentDashboard.new(payment_params) }

  before :each do
    create(:user)
    create(:vehicle)
    create(:category)
    create(:company)
    create(:invoice, type_of_invoice: 'passiva')
    create(:payment, paid: 110)
  end

  describe 'user create payment' do
    it 'it should check if the sum payed exeeds the total of the invoice' do
      expect(payment_dashboard.update_invoice).to eq(true)
    end
  end
end
