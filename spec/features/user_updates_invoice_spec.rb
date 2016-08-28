require 'rails_helper'

feature 'user' do
  scenario 'updates invoice', js: true do
    company = company('Bezzi')
    vehicle
    create_passive_invoice(company)
    visit '/companies/dashboard'
    click_on 'Fatture'
    click_link 'Fatture passive'
    click_link 'Manutenzione'
    click_link 'Aggiorna'
    fill_in 'invoice[reason]', with: "Cambiato asse"
    click_button 'Conferma'
    expect(page).to have_css 'p', text: 'Cambiato asse'
  end
end
