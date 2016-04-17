require 'rails_helper'

feature 'user' do
  scenario 'visits page new invoice' do
    company = company('Bezzi')
    create_invoice(company)
    visits_company
    click_button "Elimina fattura"
    expect(page).not_to have_css 'td', text: 'Manutenzione'
  end
end
