require 'rails_helper'

feature 'user clicks on the invoice' do 
  scenario 'sees all the invoices of that particular supplier' do
    supplier = supplier('Bezzi')
    create_record(supplier)
    create_record(supplier,'Cassa')
    visit_invoice_page
    first(:link, 'Bezzi').click
    expect(page).to have_css 'td', text: 'Bonifico'
    expect(page).to have_css 'td', text: 'Cassa'
  end


  scenario 'sees all the invoices of that particular supplier' do
    supplier_1 = supplier('Bezzi')
    supplier_2 = supplier('Autoricambi')
    create_record(supplier_1)
    create_record(supplier_2,'Cassa')
    visit_invoice_page
    first(:link, 'Autoricambi').click
    expect(page).not_to have_css 'td', text: 'Bonifico'
  end
end
