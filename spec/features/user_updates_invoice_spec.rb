require 'rails_helper'

feature 'user' do
  scenario 'updates invoice', js: true do
    sign_up
    category
    company = company('Bezzi')
    vehicle
    create_passive_invoice(company)
    visit '/invoices/1/edit?invoice_id=1'
    fill_in 'invoice[reason]', with: "Cambiato asse"
    click_button 'Conferma'
    expect(page).to have_css 'p', text: 'Cambiato asse'
  end
end
