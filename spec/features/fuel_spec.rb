require 'rails_helper'

feature 'fuel receipts' do

  before :each do
    create(:user)
    create(:category)
    @company = create(:company)
    @vehicle = create(:vehicle)
    @fuel_receipt = create(:fuel_receipt)
    sign_in
  end

  scenario 'user adds a new fuel receipt' do
    visit('/fuel_receipts')
    expect(page).to have_css '#total_fuel_receipts_vehicle', text:'300'
  end

  scenario 'user sees total per 2 receipts per vehicle' do
    create(:fuel_receipt)
    visit('/fuel_receipts')
    expect(page).to have_css '#total_fuel_receipts_vehicle', text:'600'
  end

  scenario 'user sees total per company' do
    create(:fuel_receipt)
    visit('/fuel_receipts')
    expect(page).to have_css '#total_fuel_receipts_company', text:'600'
  end

  scenario 'user updates fuel receipt' do
    update_fuel_receipt(@fuel_receipt.id)
    expect(page).to have_css '#total_fuel_receipts_vehicle', text:'324'
  end

  scenario 'user sees companies fuel receipts' do
    visit "/companies/#{@company.id}/fuel_receipts"
    expect(page).to have_css '#company_name', text:'Esso'
    expect(page).to have_css '#total_fuel_receipt', text:'300'
    expect(page).to have_css '#vehicle_plate', text:'ER354BS'
  end

  scenario 'user does not see other companies receipts' do
    create(:company, name: 'Natale')
    create(:vehicle, plate: 'BX300FC')
    visit "/companies/#{@company.id}/fuel_receipts"
    expect(page).not_to have_css '#company_name', text:'Natale'
    expect(page).not_to have_css '#vehicle_plate', text:'BX300FC'
  end

  scenario 'user sees vehicles fuel receipts' do
    visit "/vehicles/#{@vehicle.id}/fuel_receipts"
    expect(page).to have_css '#company_name', text:'Esso'
    expect(page).to have_css '#total_fuel_receipt', text:'300'
    expect(page).to have_css '#vehicle_plate', text:'ER354BS'
  end

  scenario 'user does not see other vehicles receipts' do
    company_2 = create(:company, name: 'Natale')
    vehicle_2 = create(:vehicle, plate: 'BX300FC')
    visit "/vehicles/#{@vehicle.id}/fuel_receipts"
    create(:fuel_receipt, company_id: company_2.id, vehicle_id: vehicle_2.id)
    expect(page).not_to have_css '#company_name', text:'Natale'
    expect(page).not_to have_css '#vehicle_plate', text:'BX300FC'
  end
end
