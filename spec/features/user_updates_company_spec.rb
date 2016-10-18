require 'rails_helper'

feature 'user' do
  scenario 'updates company' do
    sign_up
    category
    company('Bezzi')
    visit '/companies/1/edit'
    fill_in 'company[name]', with: 'Maca'
    fill_in 'company[adress]', with: 'Ravenna Bagnacavallo'
    fill_in 'company[number]', with: '0293-143352'
    click_button "Conferma"
    expect(page).to have_css 'a', text: 'Maca'
  end
end
