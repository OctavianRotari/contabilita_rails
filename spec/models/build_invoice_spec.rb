require 'spec_helper'

describe BuildInvoice do
  invoice_params = {taxable_vat_fields_attributes: 
                     { "1" => { taxable: "200",vat_rate: "4"}}
                   }
  invoice_params_1 = {taxable_vat_fields_attributes:{
                        "1"=>{taxable: "200",vat_rate: "4"},
                        "2"=>{taxable: "1000", vat_rate: "10"}}
                     }
  invoice_params_2 = {taxable_vat_fields_attributes:{
                        "1"=>{ taxable: "1000",vat_rate: "10"},
                        "2"=>{taxable: "100", vat_rate: "10"},
                        "3"=>{taxable: "2000", vat_rate: "10"}}
                     }

  describe '#build' do
    it 'should calculate total taxable, vat and total' do
      taxable = BuildInvoice.new(invoice_params)
      taxable.build
      expect(taxable.invoice_params[:total_taxable]).to equal(200.0)
      expect(taxable.invoice_params[:total_vat]).to equal(8.0)
      expect(taxable.invoice_params[:total]).to equal(208.0)
    end

    it 'should calculate total of two taxable, vat and total' do
      taxable = BuildInvoice.new(invoice_params_1)
      taxable.build
      expect(taxable.invoice_params[:total_taxable]).to equal(1200.0)
      expect(taxable.invoice_params[:total_vat]).to equal(108.0)
      expect(taxable.invoice_params[:total]).to equal(1308.0)
    end

    it 'should calculate total of three taxable, vat and total' do
      taxable = BuildInvoice.new(invoice_params_2)
      taxable.build
      expect(taxable.invoice_params[:total_taxable]).to equal(3100.0)
      expect(taxable.invoice_params[:total_vat]).to equal(310.0)
      expect(taxable.invoice_params[:total]).to equal(3410.0)
    end
  end
end
