require 'rails_helper'

feature 'insurance' do
  let(:insurance_category) { create(:insurance_category) }
  let(:insurance_company) { create(:insurance_company) }

  before :each do
    create(:user)
    create(:vehicle)
    insurance_category
    insurance_company
    sign_in
  end

  scenario 'user adds a new insurance contract for vehicle', js: true do
    visit('/insurances/new')
    #save_and_open_page
    #click_link('Aggiungi contratto')
    fill_in_insurance_contract('ER354BS')
    expect(page).to have_css '#company_name', text: 'Milano assicurazioni'
    expect(page).to have_css '#serial_of_contract', text: '123456'
    expect(page).to have_css '#total_insurance', text: '1100'
    expect(page).to have_css '#vehicle_plate', text: 'ER354BS'
  end
end
