require 'rails_helper'

feature 'user' do
  scenario 'updates invoice', js: true do
    company = company('Bezzi')
    create_invoice(company)
    visit '/companies'
    click_on 'Bezzi'
    click_link 'Manutenzione'
    click_link 'Aggiorna'
    fill_in 'invoice[reason]', with: "Cambiato asse"
    click_link 'Aggiorna'
    expect(page).to have_css 'a', text: 'Cambiato asse'
  end
end
