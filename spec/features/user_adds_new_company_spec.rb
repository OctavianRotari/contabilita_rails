require 'rails_helper'

feature 'user' do
  scenario 'adds new company' do
    visit '/'
    click_link 'Aziende'
    click_link 'Aggiungi azienda'
    fill_in 'company[name]', with: 'Bezzi'
    fill_in 'company[adress]', with: 'Ravenna Bagnacavallo'
    fill_in 'company[number]', with: '0293-143352'
    click_button "Aggiungi azienda"
    expect(page).to have_css 'a', text: 'Bezzi'
  end
end
