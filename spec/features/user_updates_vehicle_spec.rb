require 'rails_helper'

feature 'user' do
  scenario 'updates vehicle' do
    sign_up
    vehicle('RB342BD')
    visit '/vehicles/1/edit'
    fill_in 'vehicle[type_of_vehicle]', with: 'Trattore'
    fill_in 'vehicle[plate]', with: 'ER345BR'
    click_button "Conferma"
    expect(page).to have_css 'a', text: 'ER345BR'
  end
end
