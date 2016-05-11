require 'rails_helper'

feature 'user' do
  scenario 'deletes invoice' do
    company = company('Bezzi')
    vehicle("ER354BS")
    create_passive_invoice(company)
    visits_company
    click_button "Elimina fattura"
    expect(page).not_to have_css 'td', text: 'Manutenzione'
  end
end
