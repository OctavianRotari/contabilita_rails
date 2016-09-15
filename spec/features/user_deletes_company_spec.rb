require 'rails_helper'

feature 'user' do
  scenario 'deletes company' do
    category
    company('Bezzi')
    sign_up
    visit '/invoices/dashboard'
    click_link 'Aziende'
    click_button 'Elimina azienda'
    expect(page).not_to have_css 'a', text: 'Bezzi'
  end
end
