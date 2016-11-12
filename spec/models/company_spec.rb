require 'rails_helper'

describe Company, type: :unit do
  let(:user) { create(:user) }
  let(:category_mechanic) { create(:category) }

  before :each do
    user
  end

  describe 'company should not be created ' do
    before :each do
      category_mechanic
    end

    it 'if fields are empty' do
      company = build(:company, name: '', adress: '', number: '', category_id: '')
      company.save
      expect(company.errors.count).to eq(4)
      expect(user.companies).to eq([])
    end
  end

  describe '#company_name' do
    before :each do
      category_mechanic
    end

    it 'returns successfully' do
      company = create(:company)
      expect(company.name).to eq('Esso')
    end
  end

  describe '#gas_stations' do
    before :each do
      create(:gas_station_category)
    end

    it 'returns successfully' do
      company = create(:company)
      expect(Company.gas_stations).to eq([company])
    end

    it 'doesnt return non gas station' do
      create(:company, category_id: category_mechanic.id)
      expect(Company.gas_stations).to eq([])
    end
  end

  describe '#insurances' do
    before :each do
      create(:insurance_category)
    end

    it 'returns successfully' do
      company = create(:company)
      expect(Company.insurances).to eq([company])
    end

    it 'doesnt return non insurance companies' do
      create(:company, category_id: category_mechanic.id)
      expect(Company.insurances).to eq([])
    end

    describe '#is_insurance?' do
      it 'should return true if is an insurance company' do
        insurance_company = create(:insurance_company)
        expect(insurance_company.insurance?).to eq(true)
      end
    end
  end
end
