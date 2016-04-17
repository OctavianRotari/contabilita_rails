require 'rails_helper'

feature 'user' do
  scenario 'visits page new invoice' do
    company = company('Bezzi')
    create_invoice(company)
    visits_new_invoice
    expect(page).to have_css 'h2', text: 'Aggiungi Fattura'
  end
end
