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

  describe 'vehicle should not be created ' do
    it 'if fields are empty' do
      vehicle = Vehicle.new(plate:"",type_of_vehicle:"")
      vehicle.save
      errors_should_apear = {:plate=>["Inserire targa del veicolo"], :type_of_vehicle=>["Selezionare tipo di veicolo"]}
      expect(vehicle.errors.messages).to eq(errors_should_apear)
    end

    it 'if vehicle already exists' do
      create_vehicle()
      vehicle = Vehicle.new(plate:"ER354BS",type_of_vehicle:"trattore")
      vehicle.save
      errors_should_apear = {:plate=>["Veicolo con questa targa gia registrata"]}
      expect(vehicle.errors.messages).to eq(errors_should_apear)
    end
  end
end
