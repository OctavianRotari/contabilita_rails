require 'rails_helper'

describe Insurance, type: :model do
  let(:insurance) { Insurance.new }

  before :each do
    create(:user)
    create(:vehicle)
    create(:insurance_category)
    create(:insurance_company)
    create(:insurance)
  end

  describe '#company_name' do
    it 'should return the name of the company on whitch the insurance is registered on' do
      insurance = Insurance.first
      expect(insurance.company_name).to eq('Milano assicurazioni')
    end
  end

  describe '#vehicle_plate' do
    it 'should return the plate of the vehicle on whitch the insurance is registered on' do
      insurance = Insurance.first
      expect(insurance.vehicle_plate).to eq('ER354BS')
    end
  end
end
