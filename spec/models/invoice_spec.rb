require 'spec_helper'

describe Invoice, type: :model do
  before :each do
    company = company('Octav')
    create_record(company)
  end

  describe '#company_name' do
    it 'should return the name of the company' do
      expect(Invoice.first.company_name).to eq('Octav')
    end
  end

  describe '#company_id' do
    it 'should return the id of the company' do
      expect(Invoice.first.company_id).to eq(1)
    end
  end

  describe '#by_company' do
    it 'should return the invoices of the company' do
      company = company('Gabry')
      create_record(company)
      expect(Invoice.by_company(1).count).to eq(1)
    end
  end

end
