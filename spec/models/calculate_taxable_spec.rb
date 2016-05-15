require 'spec_helper'

describe BuildInvoice do
  invoice_params = {taxable: "200",
                    vat: "4"}
  invoice_params_1 = {taxable: "200",
                      vat: "4",
                      taxable_vat_fields_attributes:{"1"=>{taxable: "100", vat: "10"}}}
  invoice_params_2 = {taxable: "1000",
                      vat: "10",
                      taxable_vat_fields_attributes:{"1"=>{taxable: "100", vat: "10"},
                                                    "2"=>{taxable: "2000", vat: "10"}}}

  describe '#total_taxable' do
    it 'should calculate total taxable' do
      taxable = BuildInvoice.new(invoice_params)
      expect(taxable.build(invoice_params)).to equal(200.0)
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
