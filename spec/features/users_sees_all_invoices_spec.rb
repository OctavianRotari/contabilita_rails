require 'rails_helper'

feature 'user sees' do
  scenario 'all the invoices' do
    invoice = '110.0 10.0 0 110.0 Bezzi 110.0 10.0 0 110.0 Manutenzione 2015-04-01 00:00:00 UTC ER354BS 2015-04-30 00:00:00 UTC'
    company = company('Bezzi')
    vehicle("ER354BS")
    create_invoice(company)
    visit_invoice_page
    expect(page).to have_content invoice
  end
end
