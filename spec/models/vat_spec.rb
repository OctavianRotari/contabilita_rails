require 'rails_helper'

describe Vat, type: :unit do
  let(:invoice_params) { attributes_for(:invoice_params_general_expenses) }
  let(:vat) { Vat.new(invoice_params) }

  describe '#total_vat' do
    it 'calculates the total of the vat' do
      vat.total_vat
      expect(vat.invoice_params[:total_vat]).to eq(10.0)
    end
  end
end
