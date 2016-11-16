require 'rails_helper'

describe Category, type: :unit do
  let(:user) { create(:user) }

  before :each do
    user
  end

  describe 'category should not be created ' do
    it 'if fields are empty' do
      category = build(:category, name: '', type_of: nil)
      category.save
      expect(category.errors.count).to eq(2)
      expect(user.categories).to eq([])
    end
  end

  describe 'should return only gas station category' do
    it 'returns successfully' do
      category = create(:gas_station_category)
      expect(Category.gas_station).to eq(category)
    end

    it 'returns gas station id' do
      category = create(:gas_station_category)
      expect(Category.gas_station_id).to eq(category[:id])
    end
  end

  describe 'should return only insurance category' do
    let(:category) { create(:insurance_category) }

    before :each do
      category
    end

    it 'returns succcessfully' do
      expect(Category.insurance).to eq(category)
    end

    it 'returns insurances id' do
      expect(Category.insurance_id).to eq(category[:id])
    end
  end

  describe '#insurance?' do
    it 'checks if a category is an insurance category' do
      insurance_category = create(:insurance_category)
      category = create(:category)
      expect(insurance_category.insurance?).to eq(true)
      expect(category.insurance?).to eq(false)
    end
  end
end
