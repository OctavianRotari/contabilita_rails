require 'rails_helper'

feature 'user' do
  active_invoice = 'Totale: 110.0 10.0 0 110.0 Bezzi 110.0 10.0 0 110.0 Manutenzione 01-04-2015 30-04-2015'
  passive_invoice = 'Totale: 110.0 10.0 0 110.0 Bezzi 110.0 10.0 0 110.0 Manutenzione 01-04-2015 ER354BS 30-04-2015'

  scenario 'sees all the active invoices' do
    company = company('Bezzi')
    vehicle("ER354BS")
    create_active_invoice(company)
    visit_active_invoices_page
    expect(page).to have_content active_invoice
  end

  scenario 'does not see passive invoices when entering active invoice' do
    company = company('Bezzi')
    vehicle("ER354BS")
    create_passive_invoice(company)
    visit_active_invoices_page
    expect(page).not_to have_content passive_invoice
  end

  scenario 'sees all the passive invoices' do
    company = company('Bezzi')
    vehicle("ER354BS")
    create_passive_invoice(company)
    visit_passive_invoices_page
    expect(page).to have_content passive_invoice
  end

  scenario 'does not see active invoices when entering passive invoice' do
    company = company('Bezzi')
    vehicle("ER354BS")
    create_active_invoice(company)
    visit_passive_invoices_page
    expect(page).not_to have_content active_invoice
  end
end
