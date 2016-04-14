require 'rails_helper'

feature 'user clicks on the invoice' do 
  scenario 'user sees all the invoices of that particular supplier' do
    supplier = supplier('Bezzi')
    create_record(supplier)
    create_record(supplier,'Cassa')
    visit_invoice_page
    first(:link, 'Bezzi').click
    expect(page).to have_css 'td', text: 'Bonifico'
    expect(page).to have_css 'td', text: 'Cassa'
  end
end
