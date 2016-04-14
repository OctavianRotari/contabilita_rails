require 'rails_helper'

feature 'user sees own invoices' do
  scenario 'all the invoices' do
    invoice = 'Bezzi 100 21 01/04/2015 de234ed 30/04/2015 Bonifico'
    supplier = supplier('Bezzi')
    create_record(supplier)
    visit_invoice_page
    expect(page).to have_content invoice
  end
end
