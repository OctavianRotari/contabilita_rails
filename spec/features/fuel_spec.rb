require 'rails_helper'

feature 'fuel receipts' do

  before :each do
    sign_up
    category('Benzinaio', true)
    company('Esso')
    vehicle('ER354BS')
    fill_in_fuel_receipt
  end

  scenario 'user adds a new fuel receipt', js: true do
    expect(page).to have_css '#total_fuel_receipts_vehicle', text:'300'
  end

  scenario 'user sees total per 2 receipts per vehicle', js: true do
    fill_in_fuel_receipt
    expect(page).to have_css '#total_fuel_receipts_vehicle', text:'600'
  end

  scenario 'user sees total per company', js: true do
    fill_in_fuel_receipt
    expect(page).to have_css '#total_fuel_receipts_company', text:'600'
  end

  scenario 'user updates fuel receipt', js: true do
    update_fuel_receipt
    expect(page).to have_css '#total_fuel_receipts_vehicle', text:'324'
  end

  scenario 'user sees companies fuel receipts', js: true do
    visit '/companies/1/fuel_receipts'
    expect(page).to have_css '#company_name', text:'Esso'
    expect(page).to have_css '#total_fuel_receipt', text:'300'
    expect(page).to have_css '#vehicle_plate', text:'ER354BS'
  end

  scenario 'user does not see other companies receipts', js: true do
    company('Natale')
    vehicle("BX300FC")
    visit '/companies/1/fuel_receipts'
    fill_in_fuel_receipt('Natale',"BX300FC")
    expect(page).not_to have_css '#company_name', text:'Natale'
    expect(page).not_to have_css '#vehicle_plate', text:'ER354BS'
  end

  scenario 'user sees vehicles fuel receipts', js: true do
    visit '/vehicles/1/fuel_receipts'
    expect(page).to have_css '#company_name', text:'Esso'
    expect(page).to have_css '#total_fuel_receipt', text:'300'
    expect(page).to have_css '#vehicle_plate', text:'ER354BS'
  end

  scenario 'user does not see other vehicles receipts', js: true do
    company('Natale')
    vehicle("BX300FC")
    visit '/vehicles/1/fuel_receipts'
    fill_in_fuel_receipt('Natale',"BX300FC")
    expect(page).not_to have_css '#company_name', text:'Natale'
    expect(page).not_to have_css '#vehicle_plate', text:'ER354BS'
  end
end
