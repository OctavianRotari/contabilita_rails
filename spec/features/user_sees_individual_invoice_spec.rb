require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice', js: true do
    company = company('Bezzi')
    vehicle = vehicle("ER859BS")
    create_passive_invoice(vehicle)
    create_passive_invoice(company)
    visits_individual_invoice
    expect(page).to have_css 'h2', text: 'Manutenzione'
    expect(page).to have_css 'p', text: 'Inponibile: 100'
  end
end
