require 'rails_helper'

feature 'user' do
  scenario 'adds new company' do
    category
    visit '/'
    click_link 'Aziende'
    click_link 'Aggiungi azienda'
    fill_in 'company[name]', with: 'Bezzi'
    fill_in 'company[adress]', with: 'Ravenna Bagnacavallo'
    fill_in 'company[number]', with: '0293-143352'
    page.select 'officina', from: 'company[category_of_company_id]'
    click_button "Aggiungi azienda"
    expect(page).to have_css 'a', text: 'Bezzi'
  end
end
