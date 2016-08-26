require 'rails_helper'

feature 'user' do
  scenario 'adds new vehicle' do
    visit '/'
    click_link 'Mezzi'
    click_link 'Aggiungi mezzo'
    fill_in 'vehicle[type_of_vehicle]', with: 'Trattore'
    fill_in 'vehicle[plate]', with: 'ER345BR'
    click_button "Aggiungi mezzo"
    expect(page).to have_css 'a', text: 'ER345BR'
  end

  scenario 'cant add new vehicle if fields arent filled' do
    visit '/'
    click_link 'Mezzi'
    click_link 'Aggiungi mezzo'
    click_button "Aggiungi mezzo"
    expect(page).to have_content "Inserire targa del veicolo"
    expect(page).to have_content "Selezionare tipo di veicolo"
  end
end
