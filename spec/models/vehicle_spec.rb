require 'rails_helper'

describe Vehicle, type: :unit do
  before :each do
    create(:user)
    create(:category)
    @company = create(:company)
    @vehicle = create(:vehicle)
  end

  describe '#invoices' do
    it 'should have many invoices' do
      invoice = create(:invoice, type_of_invoice: 'passiva')
      invoice_2 = create(:invoice, type_of_invoice: 'passiva')
      expect(@vehicle.invoices).to eq([invoice, invoice_2])
    end
  end

  describe 'receipts' do
    it 'should have many receipts' do
      fuel_receipt = create(:fuel_receipt)
      fuel_receipt_2 = create(:fuel_receipt)
      expect(@vehicle.fuel_receipts).to eq([fuel_receipt, fuel_receipt_2])
    end

    it "should return all the vehicle's fuel receipts with a given company_id" do
      fuel_receipt = create(:fuel_receipt)
      expect(@vehicle.fuel_receipts_per_company(@company.id)).to eq([fuel_receipt])
    end

    it 'should not return fuel receipts with other ids' do
      company = create(:company)
      create(:fuel_receipt, company_id: company.id)
      expect(@vehicle.fuel_receipts_per_company(@company.id)).to eq([])
    end
  end

  describe 'vehicle should not be created ' do
    it 'if fields are empty' do
      vehicle = build(:vehicle, plate: '', type_of_vehicle: '')
      vehicle.save
      errors_should_apear = {:plate=>["Inserire targa del veicolo"], :type_of_vehicle=>["Inserire tipo di veicolo"]}
      expect(vehicle.errors.messages).to eq(errors_should_apear)
    end
  end
end
