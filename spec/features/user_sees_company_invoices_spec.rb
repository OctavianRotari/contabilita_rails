require 'rails_helper'

feature 'user clicks on the invoice' do 
  scenario 'sees all the invoices of that particular company' do
    company = company('Bezzi')
    create_record(company)
    create_record(company,'Cassa')
    visit_invoice_page
    first(:link, 'Bezzi').click
    expect(page).to have_css 'td', text: 'Bonifico'
    expect(page).to have_css 'td', text: 'Cassa'
  end


  scenario 'sees all the invoices of that particular company' do
    company_1 = company('Bezzi')
    company_2 = company('Autoricambi')
    create_record(company_1)
    create_record(company_2,'Cassa')
    visit_invoice_page
    first(:link, 'Autoricambi').click
    expect(page).not_to have_css 'td', text: 'Bonifico'
  end
end
