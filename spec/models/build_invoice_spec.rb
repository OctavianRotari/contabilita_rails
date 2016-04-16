require 'spec_helper'

describe BuildInvoice do
  invoice_params = {taxable: "200",
                    vat: "4"}
  invoice_params_1 = {taxable: "200",
                      taxable_1: "1000",
                      vat: "4",
                      vat_1: "10"}
  invoice_params_2 = {taxable: "1000",
                      taxable_1: "100",
                      taxable_2: "2000",
                      vat: "10",
                      vat_1: "10",
                      vat_2: "10"}

  describe '#vat' do
    it 'should return calculated vat' do
      build_invoice = BuildInvoice.new(invoice_params)
      expect(build_invoice.total_vat).to equal(8.0)
    end

    it 'should return calculated vat summing tow vat' do
      build_invoice_1 = BuildInvoice.new(invoice_params_1)
      expect(build_invoice_1.total_vat).to equal(108.0)
    end

    it 'should return calculated vat summing three vat' do
      build_invoice_2 = BuildInvoice.new(invoice_params_2)
      expect(build_invoice_2.total_vat).to equal(310.0)
    end
  end

  describe '#total_taxable' do
    it 'should return calculated total taxable + vat' do
      build_invoice = BuildInvoice.new(invoice_params)
      expect(build_invoice.total_taxable).to equal(200.0)
    end

    it 'should return calculated vat summing tow vat' do
      build_invoice_1 = BuildInvoice.new(invoice_params_1)
      expect(build_invoice_1.total_taxable).to equal(1200.0)
    end

    it 'should return calculated vat summing three vat' do
      build_invoice_2 = BuildInvoice.new(invoice_params_2)
      expect(build_invoice_2.total_taxable).to equal(3100.0)
    end
  end
end
