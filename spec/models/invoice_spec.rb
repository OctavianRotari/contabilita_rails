require 'spec_helper'

describe Invoice, type: :unit do
  before :each do
    company = company('Octav')
    @passive_invoice = create_passive_record(company)
    @active_invoice = create_active_record(company)
  end

  describe '#company_name' do
    it 'should return the name of the company' do
      expect(Invoice.first.company_name).to eq('Octav')
    end
  end

  describe '#payments' do
    it 'should return all the payments' do
      payments = add_payment_to_invoice(@passive_invoice)
      expect(Invoice.first.payments).to eq([payments])
    end
  end

  describe '# self active_ord_by_year' do
    it 'should not return passive invoices ' do
      params = { year_param: "2015"}
      expect(Invoice.active_ord_by_year(params)).not_to eq([@passive_invoice])
    end

    it 'should return active invoices ' do
      params = { year_param: "2015" }
      expect(Invoice.active_ord_by_year(params)).to eq([@active_invoice])
    end
  end

  describe '# self passive_ord_by_year' do
    it 'should not return passive invoices ' do
      params = { year_param: "2015"}
      expect(Invoice.passive_ord_by_year(params)).not_to eq([@active_invoice])
    end

    it 'should return active invoices ' do
      params = { year_param: "2015" }
      expect(Invoice.passive_ord_by_year(params)).to eq([@passive_invoice])
    end
  end

end
