require 'rails_helper'

describe Company, type: :unit do
  let(:user) { create(:user) }
  let(:category_mechanic) { create(:category, gas_station: false)}

  before :each do
    user
    create(:category)
  end

  describe 'company should not be created ' do
    it 'if fields are empty' do
      company = build(:company, name: '', adress: '', number: '', category_id: '')
      company.save
      expect(company.errors.count).to eq(4)
      expect(user.companies).to eq([])
    end
  end

  describe 'should return the name of the company' do
    it 'returns successfully' do
      company = create(:company)
      expect(company.name).to eq('Esso')
    end
  end

  describe 'should return only gas stations' do
    it 'returns successfully' do
      company = create(:company)
      expect(Company.gas_stations).to eq([company])
    end

    it 'doesnt return non gas station' do
      create(:company, category_id: category_mechanic.id)
      expect(Company.gas_stations).to eq([])
    end
  end
end
