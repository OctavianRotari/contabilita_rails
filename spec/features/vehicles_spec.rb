require 'rails_helper'

feature 'vehicles' do
  before :each do
    create(:user)
    sign_in
  end

  scenario 'adds new vehicle' do
    visit '/vehicles/new'
    fill_in 'vehicle[type_of_vehicle]', with: 'Trattore'
    fill_in 'vehicle[plate]', with: 'ER345BR'
    click_button 'Conferma'
    expect(page).to have_css '#vehicle_plate', text: 'ER345BR'
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
      visit('/vehicles/dashboard')
      find('.delete-vehicle').click
      expect(page).not_to have_css '#vehicle_plate', text: 'ER354BS'
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
      end

      scenario 'sees the total spent for fuel per month' do
        create(:fuel_receipt)
        visit '/vehicles/dashboard'
        expect(page).to have_css '#current_month_fuel_costs', text: '300'
      end
    end
  end
end
