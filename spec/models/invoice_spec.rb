require 'rails_helper'

describe Invoice, type: :unit do
  before :each do
    create(:user)
    create(:vehicle)
    create(:category)
    create(:company)
    @params = { year_param: Time.zone.now.year }
  end

  describe 'invoice should not be created if fields are empty' do
    it 'should have many invoices' do
      invoice = build(:invoice,
                      reason: '',
                      total: '',
                      total_vat: '',
                      user_id: '',
                      vehicle_id: '',
                      company_id: '',
                      at_the_expense_of: '',
                      category_id: '',
                      date_of_issue: '',
                      type_of_invoice: '',
                      total_taxable: '',
                      deadline: '')
      invoice.save
      expect(invoice.errors.count).to eq(6)
      expect(Invoice.all).to eq([])
    end
  end

  describe 'after invoices are created' do
    before :each do
      @passive_invoice = create(:invoice, type_of_invoice: 'passiva')
      @active_invoice = create(:invoice, type_of_invoice: 'attiva')
    end

    describe '#company_name' do
      it 'should return the name of the company' do
        expect(@passive_invoice.company_name).to eq('Esso')
      end
    end

    describe '#vehicle_plate' do
      it 'should return the plate of the vehicle on which is registered' do
        expect(@passive_invoice.vehicle_plate).to eq('ER354BS')
      end
    end

    describe '#payments' do
      it 'has many payments' do
        payment = create(:payment)
        expect(@passive_invoice.payments).to eq([payment])
      end
    end

    describe '#active_ord_by_year' do
      it 'should not return passive invoices' do
        expect(Invoice.active_ord_by_year(@params)).not_to eq([@passive_invoice])
      end

      it 'should return active invoices' do
        expect(Invoice.active_ord_by_year(@params)).to eq([@active_invoice])
      end
    end

    describe '#passive_ord_by_year' do
      it 'should not return passive invoices ' do
        expect(Invoice.passive_ord_by_year(@params)).not_to eq([@active_invoice])
      end

      it 'should return passive invoices ' do
        expect(Invoice.passive_ord_by_year(@params)).to eq([@passive_invoice])
      end
    end
  end
end
