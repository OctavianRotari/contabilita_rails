require 'rails_helper'

feature 'user' do
  scenario 'adds new vehicle' do
    sign_up
    visit '/invoices/dashboard'
    click_link 'Mezzi'
    click_link 'Aggiungi mezzo'
    fill_in 'vehicle[type_of_vehicle]', with: 'Trattore'
    fill_in 'vehicle[plate]', with: 'ER345BR'
    click_button "Aggiungi mezzo"
    expect(current_path).to eq '/vehicles/dashboard'
  end
end
