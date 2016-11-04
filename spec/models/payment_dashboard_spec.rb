require 'rails_helper'

describe PaymentDashboard, type: :unit do
  let(:invoice) { build_stubbed(:invoice, type_of_invoice: 'passiva') }
  let(:payment_params) { attributes_for(:payment, paid: 110) }
  let(:payment_dashboard) { PaymentDashboard.new(payment_params) }

  before :each do
    invoice
    payment_dashboard
  end

  describe 'user create payment' do
    it 'it should check if the sum payed exeeds the total of the invoice' do
      allow(payment_dashboard).to receive(:invoice) { invoice }
      expect(payment_dashboard.check_total).to eq(true)
    end
  end
end
