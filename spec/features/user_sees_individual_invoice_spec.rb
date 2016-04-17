require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice' do
    company = company('Bezzi')
    create_invoice(company)
    visits_individual_invoice
    expect(page).to have_css 'h2', text: 'Manutenzione'
    expect(page).to have_css 'p', text: 'Taxable: 100'
  end
end
