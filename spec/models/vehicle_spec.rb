require 'rails_helper'

describe Vehicle, type: :unit do
  let(:time_now) { Time.zone.now }
  let(:params) { {month: time_now.month, year: time_now.year, id: 1 } }
  let(:user) { create(:user) }
  let(:second_user) { create(:user, email: 'test@test.com') }

  before :each do
    user
  end

  describe 'vehicle should not be created ' do
    it 'if fields are empty' do
      vehicle = build(:vehicle, plate: '', type_of_vehicle: '')
      vehicle.save
      expect(vehicle.errors.count).to eq(2)
      expect(user.vehicles).to eq([])
    end
  end

  describe '#invoices' do
    let(:company) { create(:company) }
    let(:vehicle) { create(:vehicle) }
    let(:second_company) { create(:company) }

    before :each do
      create(:category)
      vehicle
      company
    end

    describe '#charge_general_expenses' do
      it 'should return only vehicles that will be charged of general expences' do
        vehicle_no_general_expences = create(:vehicle, charge_general_expenses: false)
        expect(Vehicle.charge_general_expenses).to eq([vehicle])
        expect(Vehicle.charge_general_expenses).not_to include(vehicle_no_general_expences)
      end
    end

    describe '#count_vehicle_general' do
      it 'returns the number of vehicles that are subject to general expenses' do
        expect(Vehicle.count_vehicles_general(user.id)).to eq(1)
        expect(Vehicle.count_vehicles_general(second_user.id)).to eq(0)
      end
    end

    describe '#fuel_receipts_month_total' do
      it 'returns the total of the current month fuel receipts' do
        create(:fuel_receipt)
        expect(vehicle.fuel_receipts_month_total.to_f).to eq(300.22)
      end

      it 'does not return other months totals' do
        create(:fuel_receipt, date_of_issue: Time.zone.now - 1.month)
        create(:fuel_receipt, date_of_issue: Time.zone.now - 1.year)
        expect(vehicle.fuel_receipts_month_total).to eq(0)
      end
    end

    describe '#fuel_receipts_year_total' do
      it 'returns the total of current month fuel receipts' do
        create(:fuel_receipt)
        create(:fuel_receipt, date_of_issue: Time.zone.now - 1.month)
        expect(vehicle.fuel_receipts_year_total.to_f).to eq(600.44)
      end

      it 'does not return other years totals' do
        create(:fuel_receipt, date_of_issue: Time.zone.now - 1.year)
        expect(vehicle.fuel_receipts_year_total).to eq(0)
      end
    end

    describe '#passive_invoices_month_total' do
      it 'returns the total of curent month passive invoices' do
        create(:passive_invoice)
        create(:invoice)
        expect(vehicle.passive_invoices_month_total).to eq(110)
      end

      it 'does not return other months totals' do
        create(:passive_invoice, date_of_issue: Time.zone.now - 1.month)
        expect(vehicle.passive_invoices_month_total).to eq(0)
      end
    end

    describe '#total_insurance_month' do
      it 'returns zero if there is no insurace' do
        expect(vehicle.total_insurance_month).to eq(0)
      end

      it 'returns zero if there is no active insurance' do
        expect(vehicle.total_insurance_month).to eq(0)
      end

      it 'does not return if insurance is not active' do
        create(:insurance, date_of_issue: Time.zone.now - 2.month, deadline: Time.zone.now - 1.month)
        expect(vehicle.total_insurance_year).to eq(0)
      end

      it 'returns the the total divided by 12 months' do
        create(:insurance, total: 1200)
        expect(vehicle.total_insurance_month).to eq(100)
      end
    end

    describe '#total_insurance_year' do
      it 'returns zero if there is no insurace' do
        expect(vehicle.total_insurance_year).to eq(0)
      end

      it 'returns zero if there is no active insurance' do
        expect(vehicle.total_insurance_year).to eq(0)
      end

      it 'does not return if insurance is not active' do
        create(:insurance, date_of_issue: Time.zone.now - 2.year, deadline: Time.zone.now - 1.year )
        expect(vehicle.total_insurance_year).to eq(0)
      end

      it 'returns the the total' do
        create(:insurance, total: 1200)
        expect(vehicle.total_insurance_year).to eq(1200)
      end
    end

    describe '#total_general_insurance_month' do
      it 'returns zero if there is no imputable' do
        create(:vehicle, charge_general_expenses: true)
        expect(vehicle.general_insurance_month).to eq(0)
      end

      it 'returns total if there are imputable' do
        create(:vehicle, charge_general_expenses: true)
        create(:general_insurance, total: 1200)
        expect(vehicle.general_insurance_month).to eq(50)
      end

      it 'returns does not count not active general insuraces' do
        vehicle = create(:vehicle, charge_general_expenses: true)
        create(:general_insurance, date_of_issue: Time.zone.now - 2.year, deadline: Time.zone.now - 1.year )
        expect(vehicle.general_insurance_month).to eq(0)
      end
    end

    describe '#total_general_insurance_year' do
      it 'returns zero if there is general insurances' do
        expect(vehicle.general_insurance_year).to eq(0)
      end

      it 'returns total if there are imputable' do
        create(:vehicle, charge_general_expenses: true)
        create(:general_insurance, total: 1200)
        expect(vehicle.general_insurance_year).to eq(600)
      end

      it 'returns does not count not active general insuraces' do
        vehicle = create(:vehicle, charge_general_expenses: true)
        create(:general_insurance, date_of_issue: Time.zone.now - 2.year, deadline: Time.zone.now - 1.year )
        expect(vehicle.general_insurance_year).to eq(0)
      end
    end

    describe '#general_expenses_month' do
      it 'returns zero if there is no general expences' do
        expect(vehicle.general_expenses_month).to eq(0)
      end

      it 'returns total if there are imputable' do
        create(:vehicle, charge_general_expenses: true)
        create(:general_expenses_invoice, total: 1200)
        expect(vehicle.general_expenses_month).to eq(600)
      end

      it 'returns does not count not other month general invoices' do
        vehicle = create(:vehicle, charge_general_expenses: true)
        create(:general_expenses_invoice, date_of_issue: Time.zone.now - 1.month)
        expect(vehicle.general_expenses_month).to eq(0)
      end
    end

    describe '#general_expenses_year' do
      it 'returns zero if there is no general expences' do
        expect(vehicle.general_expenses_year).to eq(0)
      end

      it 'returns total if there are imputable' do
        create(:vehicle, charge_general_expenses: true)
        create(:general_expenses_invoice, total: 1200)
        expect(vehicle.general_expenses_year).to eq(600)
      end

      it 'returns does not count not other year general invoices' do
        vehicle = create(:vehicle, charge_general_expenses: true)
        create(:general_expenses_invoice, date_of_issue: Time.zone.now - 1.year)
        expect(vehicle.general_expenses_year).to eq(0)
      end
    end

    describe '#vehicle_field_month' do
      it 'returns zero if there are no vehicle_fields' do
        expect(vehicle.vehicle_field_month).to eq(0)
      end

      it 'returns the total of the fields for the current month per vehicle' do
        create(:invoice)
        create(:vehicle_field)
        create(:vehicle_field)
        create(:vehicle_field, created_at: Time.zone.now - 1.month)
        expect(vehicle.vehicle_field_month).to eq(600)
      end
    end

    describe '#vehicle_field_year' do
      it 'returns zero if there are no vehicle_fields' do
        expect(vehicle.vehicle_field_year).to eq(0)
      end

      it 'returns the total of the fields for the current month per vehicle' do
        create(:invoice)
        create(:vehicle_field)
        create(:vehicle_field)
        create(:vehicle_field, created_at: Time.zone.now - 1.year)
        expect(vehicle.vehicle_field_year).to eq(600)
      end
    end

    describe '#total_tickets' do
      it 'return zero if there are no tickets' do
        expect(vehicle.total_tickets_month).to eq(0)
      end

      describe 'month' do
        it 'return the total of tickets' do
          create(:ticket)
          create(:ticket, date_of_issue: Time.zone.now - 1.month)
          expect(vehicle.total_tickets_month).to eq(90)
        end
      end

      describe 'year' do
        it 'return the total of tickets' do
          create(:ticket)
          create(:ticket, date_of_issue: Time.zone.now - 1.year)
          expect(vehicle.total_tickets_year).to eq(90)
        end
      end
    end

    describe '#total_administrative_tickets' do
      it 'return zero if there are no tickets' do
        expect(vehicle.total_administrative_tickets_month).to eq(0)
      end

      describe 'month' do
        it 'return the total of tickets' do
          create(:administrative_ticket)
          create(:administrative_ticket, date_of_issue: Time.zone.now - 1.month)
          expect(vehicle.total_administrative_tickets_month).to eq(90)
        end
      end

      describe 'year' do
        it 'return the total of tickets' do
          create(:administrative_ticket)
          create(:administrative_ticket, date_of_issue: Time.zone.now - 1.year)
          expect(vehicle.total_administrative_tickets_year).to eq(90)
        end
      end
    end

    describe '#receipts' do
      it "should return all the vehicle's fuel receipts with a given company_id" do
        fuel_receipt = create(:fuel_receipt)
        expect(vehicle.fuel_receipts_per_company(company.id)).to eq(fuel_receipt.total)
      end

      it 'should not return fuel receipt total with other ids' do
        create(:fuel_receipt, company_id: second_company.id)
        expect(vehicle.fuel_receipts_per_company(company.id)).to eq(0)
      end
    end
  end
end
