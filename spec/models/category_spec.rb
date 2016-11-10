require 'rails_helper'

describe Category, type: :unit do
  let(:user) { create(:user) }

  before :each do
    user
  end

  describe 'category should not be created ' do
    it 'if fields are empty' do
      category = build(:category, name: '')
      category.save
      expect(category.errors.count).to eq(1)
      expect(user.categories).to eq([])
    end
  end

  describe 'should return only gas station category' do
    it 'returns successfully' do
      category = create(:category)
      expect(Category.gas_station).to eq(category)
    end

    it 'returns gas station id' do
      category = create(:category)
      expect(Category.gas_station_id).to eq(category[:id])
    end
  end

  describe 'should return only insurance category' do
    it 'returns succcessfully' do
      category = create(:category, gas_station: false, insurance: true)
      expect(Category.insurance).to eq(category)
    end
  end
end
