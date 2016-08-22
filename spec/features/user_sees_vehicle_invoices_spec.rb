require 'rails_helper'

feature 'user' do
  scenario 'sees active invoices for a specific vehicle', js: true do
    company = company('Bezzi')
    vehicle('RB342BD')
    create_passive_invoice(company,'Montaggio gomme')
    visits_passive_invoices("Mezzi")
    expect(page).to have_css 'td', text: 'Montaggio gomme'
  end
end
