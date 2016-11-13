require 'rails_helper'

describe Insurance, type: :model do
  let(:insurance) { create(:insurance) }

  before :each do
    create(:user)
    create(:vehicle)
    create(:insurance_category)
    create(:insurance_company)
  end

  describe '#company_name' do
    it 'should return the name of the company on whitch the insurance is registered on' do
      expect(insurance.company_name).to eq('Milano assicurazioni')
    end
  end

  describe '#vehicle_plate' do
    it 'should return the plate of the vehicle on whitch the insurance is registered on' do
      expect(insurance.vehicle_plate).to eq('ER354BS')
    end
  end

  describe '#payment_date' do
    it 'shoud return the due date of payment of insurance' do
      expect(insurance.payment_date).to eq((Time.zone.now + 3.months).strftime("%d-%m-%Y"))
    end
  end

  describe '#total_receipts' do
    it 'should return the sum of the receipts' do
      insurance
      create(:receipt)
      expect(insurance.total_receipts).to eq(1100)
    end
  end
end
