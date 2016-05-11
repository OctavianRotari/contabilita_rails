require 'rails_helper'

feature 'user clicks on the invoice' do 
  scenario 'sees all the invoices of that particular company' do
    company = company('Bezzi')
    vehicle("ER859BS")
    create_passive_invoice(company,'Montaggio gomme')
    create_passive_invoice(company)
    visits_company
    expect(page).to have_css 'td', text: 'Manutenzione'
    expect(page).to have_css 'td', text: 'Montaggio gomme'
  end


  scenario 'and does not see the invoices of the other companies' do
    company_1 = company('Bezzi')
    vehicle("ER859BS")
    company_2 = company('Autoricambi')
    vehicle("ER759BS")
    create_passive_invoice(company_1)
    create_passive_invoice(company_2,'Montaggio gomme')
    visits_company
    expect(page).not_to have_css 'td', text: 'Montaggio gomme'
  end
end
