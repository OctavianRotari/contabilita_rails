require 'rails_helper'

feature 'user' do
  scenario 'deletes payment', js: true do
    company = company('Bezzi')
    vehicle("ER354BS")
    invoice = create_passive_invoice(company)
    create_payment(invoice)
    visits_individual_invoice
    click_button 'Elimina pagamento'
    expect(page).not_to have_css 'p', text: 'Totale pagamento:100.0'
  end
end
