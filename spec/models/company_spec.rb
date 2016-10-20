require 'spec_helper'

describe Company, type: :unit do
  describe '#invoices' do
    it 'should have many invoices' do
      create_vehicle
      create_category
      company = create_company('Octav')
      create_passive_record(company)
      expect(company.invoices).not_to be_empty
    end
  end

  describe 'company should not be created ' do
    it 'if fields are empty' do
      create_category
      company = Company.new(name:"",adress:"",number:"")
      company.save
      errors_should_apear = {:name=>["Inserire nome dell'azienda"], :adress=>["Inserire indirizzo dell'azienda"], :number=>["Inserire numero telefonico dell'azienda"], :category_id=>["Selezionare categoria dell'azienda"]}
      expect(company.errors.messages).to eq(errors_should_apear)
    end
  end
end
