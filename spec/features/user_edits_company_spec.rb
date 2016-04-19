require 'rails_helper'

feature 'user' do
  scenario 'visits add new company' do
    company('Bezzi')
    visit '/'
    click_link 'Aziende'
    click_link 'Aggiorna azienda'
    fill_in 'company[name]', with: 'Maca'
    fill_in 'company[adress]', with: 'Ravenna Bagnacavallo'
    fill_in 'company[number]', with: '0293-143352'
    click_button "Aggiungi azienda"
    expect(page).to have_css 'h2', text: 'Maca'
  end
end
