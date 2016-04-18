#require 'spec_helper'

#describe CalculateVat do
  #invoice_params = {taxable_1: "200",
                    #vat_1: "4"}
  #invoice_params_1 = {taxable_1: "200",
                      #taxable_2: "1000",
                      #vat_1: "4",
                      #vat_2: "10"}
  #invoice_params_2 = {taxable_1: "1000",
                      #taxable_2: "100",
                      #taxable_3: "2000",
                      #vat_1: "10",
                      #vat_2: "10",
                      #vat_3: "10"}

  #describe '#vat' do
    #it 'should calculate vat' do
      #vat = CalculateVat.new(invoice_params)
      #expect(vat.total_vat).to equal(8.0)
    #end

    #it 'should calculate sum of two vat' do
      #vat = CalculateVat.new(invoice_params_1)
      #expect(vat.total_vat).to equal(108.0)
    #end

    #it 'should calculate sum of three vat' do
      #vat = CalculateVat.new(invoice_params_2)
      #expect(vat.total_vat).to equal(310.0)
    #end
  #end
#end
