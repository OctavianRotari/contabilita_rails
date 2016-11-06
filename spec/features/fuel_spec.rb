require 'rails_helper'

feature 'fuel receipts' do
  let(:company) { create(:company) }
  let(:vehicle) { create(:vehicle) }
  let(:fuel_receipt) { create(:fuel_receipt) }

  before :each do
    create(:user)
    create(:category)
    company
    vehicle
    fuel_receipt
    sign_in
  end

  scenario 'user adds a new fuel receipt' do
    visit('/fuel_receipts')
    expect(page).to have_css '#total_fuel_receipts_vehicle', text: '300'
  end

  scenario 'user updates fuel receipt' do
    update_fuel_receipt(fuel_receipt.id)
    expect(page).to have_css '#total_fuel_receipts_vehicle', text: '324'
  end

  scenario 'user sees companies fuel receipts' do
    visit "/companies/#{company.id}/fuel_receipts"
    expect(page).to have_css '#company_name', text: 'Esso'
    expect(page).to have_css '#total_fuel_receipt', text: '300'
    expect(page).to have_css '#vehicle_plate', text: 'ER354BS'
  end

  scenario 'user sees vehicles fuel receipts' do
    visit "/vehicles/#{vehicle.id}/fuel_receipts"
    expect(page).to have_css '#company_name', text: 'Esso'
    expect(page).to have_css '#total_fuel_receipt', text: '300'
    expect(page).to have_css '#vehicle_plate', text: 'ER354BS'
  end

  feature 'user sees total fuel receipts' do
    before :each do
      create(:fuel_receipt)
      visit('/fuel_receipts')
    end

    scenario '2 receipts per vehicle' do
      expect(page).to have_css '#total_fuel_receipts_vehicle', text: '600'
    end

    scenario 'company' do
      expect(page).to have_css '#total_fuel_receipts_company', text: '600'
    end
  end

  feature 'user does not see' do
    let(:company_2) { create(:company, name: 'Natale') }
    let(:vehicle_2) { create(:vehicle, plate: 'BX300FC') }

    before :each do
      company_2
      vehicle_2
    end

    scenario 'user does not see other companies receipts' do
      visit "/companies/#{company.id}/fuel_receipts"
      expect(page).not_to have_css '#company_name', text: 'Natale'
      expect(page).not_to have_css '#vehicle_plate', text: 'BX300FC'
    end

    scenario 'user does not see other vehicles receipts' do
      visit "/vehicles/#{vehicle.id}/fuel_receipts"
      create(:fuel_receipt, company_id: company_2.id, vehicle_id: vehicle_2.id)
      expect(page).not_to have_css '#company_name', text: 'Natale'
      expect(page).not_to have_css '#vehicle_plate', text: 'BX300FC'
    end
  end
end
