require 'rails_helper'

feature 'user clicks on the company' do 
  scenario 'sees all passive invoices of that particular company', js: true do
    company = company('Bezzi')
    vehicle("ER859BS")
    create_passive_invoice(company,'Montaggio gomme')
    create_passive_invoice(company)
    visits_passive_invoices_of_company
    expect(page).to have_css 'td', text: 'Manutenzione'
    expect(page).to have_css 'td', text: 'Montaggio gomme'
  end


  scenario 'and does not see the invoices of the other companies', js: true do
    company_1 = company('Bezzi')
    vehicle("ER859BS")
    company_2 = company('Autoricambi')
    vehicle("ER759BS")
    create_passive_invoice(company_1)
    create_passive_invoice(company_2,'Montaggio gomme')
    visits_passive_invoices_of_company
    expect(page).not_to have_css 'td', text: 'Montaggio gomme'
  end
end
