require 'spec_helper'

describe Company, type: :unit do
  describe '#invoices' do
    it 'should have many invoices' do
      company = company('Octav')
      create_passive_record(company)
      expect(Company.invoices(1)).not_to be_empty
    end
  end

  describe 'company should not be created ' do
    it 'if fields are empty' do
      company = Company.new(name:"",adress:"",number:"")
      company.save
      errors_should_apear = {:name=>["Inserire nome dell'azienda"], :number=>["Inserire numero telefonico dell'azienda"], :adress=>["Inserire indirizzo dell'azienda"]}
      expect(company.errors.messages).to eq(errors_should_apear)
    end
  end

    it 'if company already exists' do
      company("Bezzi")
      company = Company.new(name:"Bezzi",adress:"via felice",number:"231")
      company.save
      errors_should_apear = {:name=>["Azienda con questo nome gia registrata"]}
      expect(company.errors.messages).to eq(errors_should_apear)
  end
end
