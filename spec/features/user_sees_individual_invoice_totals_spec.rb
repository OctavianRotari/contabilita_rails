require 'rails_helper'

feature 'user' do
  scenario "user sees individual invoice's totals", js: true do
    company = company('Bezzi')
    vehicle = vehicle("ER859BS")
    create_passive_invoice(vehicle)
    create_passive_invoice(company)
    visits_passive_invoices_of_company
    expect(page).to have_css 'tr.totals', text: '110'
    expect(page).to have_css 'tr.totals', text: '10'
  end
end
