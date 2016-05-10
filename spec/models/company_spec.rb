require 'spec_helper'

describe Company, type: :unit do
  describe '#invoices' do
    it 'should have many invoices' do
      company = company('Octav')
      create_record(company)
      expect(Company.invoices(1)).not_to be_empty
    end
  end
end
