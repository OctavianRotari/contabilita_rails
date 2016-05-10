require 'spec_helper'

describe Invoice, type: :unit do
  before :each do
    company = company('Octav')
    create_record(company)
  end

  describe '#company_name' do
    it 'should return the name of the company' do
      expect(Invoice.first.company_name).to eq('Octav')
    end
  end

end
