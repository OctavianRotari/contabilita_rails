require 'rails_helper'

describe Taxable, type: :unit do
  let(:invoice_params) { attributes_for(:invoice_params) }
  let(:taxable) { Taxable.new(invoice_params) }

  describe '#total_vat' do
    it 'calculates the total of the taxable' do
      taxable.total_taxable
      expect(taxable.invoice_params[:total_taxable]).to eq(100.0)
    end
  end
end
