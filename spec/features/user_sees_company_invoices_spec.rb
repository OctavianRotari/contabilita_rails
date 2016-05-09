require 'rails_helper'

feature 'user clicks on the invoice' do 
  scenario 'sees all the invoices of that particular company' do
    company = company('Bezzi')
    vehicle("ER859BS")
    create_invoice(company,'Montaggio gomme')
    create_invoice(company)
    visit_invoice_page
    first(:link, 'Bezzi').click
    expect(page).to have_css 'td', text: 'Manutenzione'
    expect(page).to have_css 'td', text: 'Montaggio gomme'
  end


  scenario 'sees all the invoices of that particular company' do
    company_1 = company('Bezzi')
    vehicle("ER859BS")
    company_2 = company('Autoricambi')
    vehicle("ER759BS")
    create_invoice(company_1)
    create_invoice(company_2,'Montaggio gomme')
    visit_invoice_page
    first(:link, 'Autoricambi').click
    expect(page).not_to have_css 'td', text: 'Manutenzione'
  end
end
