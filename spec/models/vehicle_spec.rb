require 'spec_helper'

describe Vehicle, type: :unit do
  describe '#invoices' do
    it 'should have many invoices' do
      company = company('Octav')
      create_vehicle
      create_passive_record(company)
      expect(Vehicle.invoices(1)).not_to be_empty
    end
  end
end
