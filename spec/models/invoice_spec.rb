require 'rails_helper'

describe Invoice, type: :unit do
  let(:user) { create(:user) }
  let(:params) { { year_param: Time.zone.now.year } }

  before :each do
    user
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
    let(:passive_invoice) { create(:passive_invoice) }
    let(:active_invoice) { create(:invoice) }

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

    describe '#total_all' do
      it 'returns the total of all invoices' do
        passive_invoice
        create(:passive_invoice)
        expect(Invoice.passive.total_all).to eq(220)
      end
    end

    describe '#total_vat_all' do
      it 'returns the total of all invoices' do
        passive_invoice
        create(:passive_invoice)
        expect(Invoice.passive.total_vat_all).to eq(20)
      end
    end

    describe '#not_paid' do
      let(:paid_passive_invoice) { create(:passive_invoice, paid: true) }

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
      let(:collected_active_invoice) { create(:invoice, paid: true) }

      it 'should return all the invoices that are not collected' do
        invoice = active_invoice
        expect(Invoice.not_collected).to eq([invoice])
      end

      it 'should not retursn the invoices that are collected' do
        collected_active_invoice
        expect(Invoice.not_collected).to eq([])
      end
    end

    describe 'current month passive' do
      before :each do
        passive_invoice
        create(:passive_invoice, date_of_issue: Time.zone.now - 1.month)
      end

      describe '#current month passive invoices' do
        it 'returns only invoices that have been registered current month' do
          expect(Invoice.month_passive).to eq([passive_invoice])
       end
      end

      describe '#month_passive_total' do
        it 'returns the total of current month passive invoices' do
          expect(Invoice.month_passive_total).to eq(110)
        end
      end
    end

    describe '#current month active invoices' do
      it 'returns only invoices that have been registered current month' do
        create(:invoice, date_of_issue: Time.zone.now - 1.month)
        expect(Invoice.month_active).to eq([active_invoice])
      end
    end

    describe 'current year passive' do
      before :each do
        passive_invoice
        create(:passive_invoice, date_of_issue: Time.zone.now - 1.year)
      end

      describe '#current year passive invoices' do
        it 'returns only invoices that have been registered current year' do
          expect(Invoice.year_passive).to eq([passive_invoice])
        end
      end

      describe '#year_passive_total' do
        it 'returns the total of current month passive invoices' do
          expect(Invoice.year_passive_total).to eq(110)
        end
      end
    end

    describe '#current year active invoices' do
      it 'returns only invoices that have been registered current year' do
        create(:invoice, date_of_issue: Time.zone.now - 1.year)
        expect(Invoice.year_active).to eq([active_invoice])
      end
    end

    describe 'general expences' do
      let(:user_two) { create(:user, email: 'test@test.com') }

      before :each do
        user_two
      end

      describe '#month_general_expenses' do
        it 'returns genera expenses invoices current user' do
          invoice = create(:general_expenses_invoice)
          create(:general_expenses_invoice, date_of_issue: Time.zone.now - 1.month)
          create(:general_expenses_invoice, user_id: user_two.id)
          expect(Invoice.month_general_expenses(user.id)).to eq([invoice])
        end
      end

      describe '#year_general_expenses' do
        it 'returns genera expenses invoices current user' do
          invoice = create(:general_expenses_invoice)
          create(:general_expenses_invoice, date_of_issue: Time.zone.now - 1.year)
          create(:general_expenses_invoice, user_id: user_two.id)
          expect(Invoice.year_general_expenses(user.id)).to eq([invoice])
        end
      end
    end
  end
end
