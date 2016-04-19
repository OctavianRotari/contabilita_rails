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

  describe '#total_taxable' do
    it 'should calculate total taxable' do
      taxable = BuildInvoice.new(invoice_params)
      expect(taxable.total_taxable(invoice_params)).to equal(200.0)
    end

    it 'should calculate sum of two taxable' do
      taxable = BuildInvoice.new(invoice_params_1)
      expect(taxable.total_taxable(invoice_params_1)).to equal(1200.0)
    end

    it 'should calculate sum of three taxable' do
      taxable = BuildInvoice.new(invoice_params_2)
      expect(taxable.total_taxable(invoice_params_2)).to equal(3100.0)
    end
  end
end
