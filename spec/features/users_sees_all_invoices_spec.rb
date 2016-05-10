require 'rails_helper'

feature 'user sees' do
  scenario 'all the invoices' do
    invoice = 'Totale: 110.0 10.0 0 110.0 Bezzi 110.0 10.0 0 110.0 Manutenzione 01-04-2015 ER354BS 30-04-2015'
    company = company('Bezzi')
    vehicle("ER354BS")
    create_invoice(company)
    visit_invoice_page
    expect(page).to have_content invoice
  end
end
