require 'rails_helper'

describe Invoice, type: :unit do
  let(:params) { { year_param: Time.zone.now.year } }

  before :each do
    create(:user)
    create(:vehicle)
    create(:category)
    create(:company)
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
    let(:passive_invoice) { create(:invoice, type_of_invoice: 'passiva') }
    let(:active_invoice) { create(:invoice, type_of_invoice: 'attiva') }

    describe '#company_name' do
      it 'should return the name of the company' do
        expect(passive_invoice.company_name).to eq('Esso')
      end
    end

    describe '#vehicle_plate' do
      it 'should return the plate of the vehicle on which is registered' do
        expect(passive_invoice.vehicle_plate).to eq('ER354BS')
      end
    end

    describe '#payments' do
      let(:payment) { create(:payment) }

      before :each do
        passive_invoice
      end

      it 'has many payments' do
        expect(passive_invoice.payments).to eq([payment])
      end

      it 'returns the total of the payments' do
        payment
        expect(passive_invoice.total_payments).to eq(100)
      end
    end

    describe '#not_paid' do
      let(:paid_passive_invoice) { create(:invoice, type_of_invoice: 'passiva', paid: true) }

      it 'should return all the invoices that are not paid' do
        invoice = passive_invoice
        expect(Invoice.not_paid).to eq([invoice])
      end

      it 'should not retursn the invoices that are paid' do
        paid_passive_invoice
        expect(Invoice.not_paid).to eq([])
      end
    end

    describe '#not_collected' do
      let(:collected_active_invoice) { create(:invoice, type_of_invoice: 'attiva', paid: true) }

      it 'should return all the invoices that are not collected' do
        invoice = active_invoice
        expect(Invoice.not_collected).to eq([invoice])
      end

      it 'should not retursn the invoices that are collected' do
        collected_active_invoice
        expect(Invoice.not_collected).to eq([])
      end
    end

    describe '#current month passive invoices' do
      it 'shoud return only invoices that have been registered current month' do
        create(:invoice, date_of_issue: Time.zone.now - 1.month)
        expect(Invoice.current_month_passive_invoices).to eq([passive_invoice])
      end
    end

    describe '#current year passive invoices' do
      it 'shoud return only invoices that have been registered current month' do
        create(:invoice, date_of_issue: Time.zone.now - 1.year)
        expect(Invoice.current_year_passive_invoices).to eq([passive_invoice])
      end
    end

    describe '#active_ord_by_year' do
      it 'should not return passive invoices' do
        expect(Invoice.active_ord_by_year(params)).not_to eq([passive_invoice])
      end

      it 'should return active invoices' do
        expect(Invoice.active_ord_by_year(params)).to eq([active_invoice])
      end
    end

    describe '#passive_ord_by_year' do
      it 'should not return passive invoices ' do
        expect(Invoice.passive_ord_by_year(params)).not_to eq([active_invoice])
      end

      it 'should return passive invoices ' do
        expect(Invoice.passive_ord_by_year(params)).to eq([passive_invoice])
      end
    end
  end
end
