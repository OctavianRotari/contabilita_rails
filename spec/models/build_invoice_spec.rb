require 'rails_helper'

describe BuildInvoice, type: :unit do
  let(:invoice_params) { attributes_for(:invoice_params) }
  let(:build_invoice) { BuildInvoice.new(invoice_params) }

  before :each do
    create(:user)
    create(:category)
    create(:company)
    create(:vehicle)
  end

  describe '#build' do
    it 'shold call the added fields methods which extracts vat and taxable' do
      build_invoice.build
      expect(build_invoice.invoice_params[:category_id]).to eq(1)
      expect(build_invoice.invoice_params[:at_the_expense_of]).to eq('Veicolo')
      expect(build_invoice.invoice_params[:total_vat]).to eq(10.0)
      expect(build_invoice.invoice_params[:total_taxable]).to eq(100.0)
      expect(build_invoice.invoice_params[:total]).to eq(110.0)
    end
  end
end
