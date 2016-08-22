require 'rails_helper'

feature 'user clicks on the company' do 
  scenario 'sees all passive invoices of that particular company', js: true do
    company = company('Bezzi')
    vehicle("ER859BS")
    create_passive_invoice(company,'Montaggio gomme')
    create_passive_invoice(company)
    visits_passive_invoices("Aziende")
    expect(page).to have_css 'td', text: 'Manutenzione'
    expect(page).to have_css 'td', text: 'Montaggio gomme'
  end
end
