require 'rails_helper'

feature 'vehicles' do
  before :each do
    create(:user)
    sign_in
  end

  feature 'adds a new vehicle'do
    before :each do
      visit '/vehicles/new'
      fill_in 'vehicle[type_of_vehicle]', with: 'Trattore'
      fill_in 'vehicle[plate]', with: 'ER345BR'
      page.check 'Imputazione delle spese generali'
      click_button 'Conferma'
    end

    scenario 'user can see the plate of the new vehicle' do
      expect(page).to have_css '#vehicle_plate', text: 'ER345BR'
    end

    scenario 'the vehicle is chargeable of general expences' do
      vehicle = Vehicle.first
      expect(vehicle.charge_general_expenses).to eq(true)
    end
  end

  feature 'vehicle already exists' do
    before :each do
      create(:vehicle)
      visit '/vehicles/dashboard'
    end

    scenario 'updates vehicle' do
      visit '/vehicles/1/edit'
      fill_in 'vehicle[type_of_vehicle]', with: 'Trattore'
      fill_in 'vehicle[plate]', with: 'BX080PA'
      click_button 'Conferma'
      expect(page).to have_css '#vehicle_plate', text: 'BX080PA'
    end

    scenario 'deletes vehicle' do
      find('.delete-vehicle').click
      expect(page).not_to have_css '#vehicle_plate', text: 'ER354BS'
    end

    scenario "visits vehicle's invoices" do
      find('#invoices').click
      expect(page).to have_content('ER354BS')
    end

    feature 'and has invoices' do
      before :each do
        create(:category)
        create(:company)
        create(:invoice, type_of_invoice: 'passiva')
        visit '/vehicles/dashboard'
      end

      scenario 'sees the costs for the vehicle for the current month' do
        expect(page).to have_css '#current_month_costs', text: '110'
      end

      scenario 'sees the costs for the vehicle for the current year' do
        expect(page).to have_css '#current_year_costs', text: '110'
      end
    end

    feature 'and has fuel receipts' do
      before :each do
        create(:category)
        create(:company)
        create(:invoice, type_of_invoice: 'passiva')
        create(:fuel_receipt)
      end

      scenario 'sees the total spent for fuel per month' do
        visit '/vehicles/dashboard'
        expect(page).to have_css '#current_month_fuel_costs', text: '300'
      end

      scenario 'user sees vehicles fuel receipts' do
        find('#fuel_receipts').click
        expect(page).to have_css '#vehicle_plate', text: 'ER354BS'
        expect(page).to have_css '#total_fuel_receipt', text: '300'
      end
    end

    feature 'and has insurance' do
      before :each do
        create(:insurance_category)
        create(:insurance_company)
        create(:insurance, total: 1200)
      end

      scenario 'sees the total spent for insurance per month' do
        visit '/vehicles/dashboard'
        expect(page).to have_css '#current_month_costs', text: '100'
      end

      scenario 'sees the total spent for insurance per year' do
        visit '/vehicles/dashboard'
        expect(page).to have_css '#current_year_costs', text: '1200'
      end
    end
  end
end
