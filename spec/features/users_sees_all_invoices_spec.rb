require 'rails_helper'

feature 'user sees' do
  scenario 'all the invoices' do
    invoice = 'Bezzi 110.0 Manutenzione 10.0 2015-04-01 00:00:00 UTC de234ed 2015-04-30 00:00:00 UTC'
    company = company('Bezzi')
    create_invoice(company)
    visit_invoice_page
    expect(page).to have_content invoice
  end
end
