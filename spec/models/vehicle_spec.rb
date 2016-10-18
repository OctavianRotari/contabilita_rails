require 'spec_helper'

describe Vehicle, type: :unit do
  describe '#invoices' do
    it 'should have many invoices' do
      create_category
      company = create_company('Octav')
      vehicle = create_vehicle
      create_passive_record(company)
      expect(vehicle.invoices).not_to be_empty
    end
  end

  describe 'vehicle should not be created ' do
    it 'if fields are empty' do
      vehicle = Vehicle.new(plate:"",type_of_vehicle:"")
      vehicle.save
      errors_should_apear = {:plate=>["Inserire targa del veicolo"], :type_of_vehicle=>["Inserire tipo di veicolo"]}
      expect(vehicle.errors.messages).to eq(errors_should_apear)
    end
  end
end
