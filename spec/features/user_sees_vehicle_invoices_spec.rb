require 'rails_helper'

feature 'user' do
  before :each do
    sign_up
    create_passive_record('Bezzi', 'ER354BS')
    visit '/vehicles/dashboard'
  end

  scenario 'sees the costs for the vehicle for the current month' do
    expect(page).to have_css '#current_month_costs', text: '110'
  end

  scenario 'sees the costs for the vehicle for the current year' do
    expect(page).to have_css '#current_year_costs', text: '110'
  end

  scenario 'sees the total spent for fuel per month', js: true do
    category('Benzinaio', true)
    company('Esso', 2)
    fill_in_fuel_receipt
    visit '/vehicles/dashboard'
    expect(page).to have_css '#current_month_fuel_costs', text: '300'
  end
end
