require 'rails_helper'

describe Payment, type: :unit do
  let(:invoice) { create(:invoice) }

  before :each do
    create(:user)
    create(:category)
    create(:company)
    create(:vehicle)
    invoice
  end

  describe 'payment should should not be created' do
    it 'if fields are empty' do
      payment = build(:payment, paid: '', method_of_payment: '', payment_date: '')
      payment.save
      expect(payment.errors.count).to eq(3)
      expect(invoice.payments).to eq([])
    end
  end
end
