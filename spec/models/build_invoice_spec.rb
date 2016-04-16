require 'spec_helper'

describe BuildInvoice do
  invoice_params = {taxable_1: "200",
                    vat_1: "4"}
  invoice_params_1 = {taxable_1: "200",
                      taxable_2: "1000",
                      vat_1: "4",
                      vat_2: "10"}
  invoice_params_2 = {taxable_1: "1000",
                      taxable_2: "100",
                      taxable_3: "2000",
                      vat_1: "10",
                      vat_2: "10",
                      vat_3: "10"}

  describe '#total' do
    it 'should return calculated total taxable + vat' do
      build_invoice = BuildInvoice.new(invoice_params)
      expect(build_invoice.total).to eq({total:208.0, vat:8.0})
    end

    it 'should return calculated total taxable + vat' do
      build_invoice_1 = BuildInvoice.new(invoice_params_1)
      expect(build_invoice_1.total).to eq({total:1308.0, vat:108.0})
    end

    it 'should return calculated total taxable + vat' do
      build_invoice_2 = BuildInvoice.new(invoice_params_2)
      expect(build_invoice_2.total).to eq({total:3410.0, vat:310.0})
    end
  end
end
