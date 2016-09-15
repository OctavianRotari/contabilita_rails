require 'rails_helper'

feature 'user' do
  scenario 'updates company' do
    vehicle('RB342BD')
    sign_up
    visit '/invoices/dashboard'
    click_link 'Mezzi'
    click_link 'Aggiorna mezzo'
    fill_in 'vehicle[type_of_vehicle]', with: 'Trattore'
    fill_in 'vehicle[plate]', with: 'ER345BR'
    click_button "Aggiungi mezzo"
    expect(page).to have_css 'a', text: 'ER345BR'
  end
end
