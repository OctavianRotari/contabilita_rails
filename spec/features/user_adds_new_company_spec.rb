require 'rails_helper'

feature 'user' do
  scenario 'adds new company' do
    sign_up
    category
    visit '/invoices/dashboard'
    click_link 'Aggiungi azienda'
    fill_in 'company[name]', with: 'Bezzi'
    fill_in 'company[adress]', with: 'Ravenna Bagnacavallo'
    fill_in 'company[number]', with: '0293-143352'
    page.select 'officina', from: 'company[category_id]'
    click_button "Aggiungi azienda"
    expect(page).to have_css 'a', text: 'Bezzi'
  end
end
