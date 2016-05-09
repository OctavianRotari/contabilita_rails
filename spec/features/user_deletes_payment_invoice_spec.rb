require 'rails_helper'

feature 'user' do
  scenario 'deletes payment' do
    company = company('Bezzi')
    vehicle("ER354BS")
    invoice = create_invoice(company)
    create_payment(invoice)
    visits_individual_invoice
    click_button 'Elimina pagamento'
    expect(page).not_to have_css 'p', text: 'Totale pagamento:100.0'
  end
end
