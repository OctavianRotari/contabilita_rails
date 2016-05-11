require 'rails_helper'

feature 'user' do
  scenario 'updates a payment' do
    company = company('Bezzi')
    vehicle("ER354BS")
    invoice = create_passive_invoice(company)
    create_payment(invoice)
    visits_individual_invoice
    click_link 'Aggiorna pagamento'
    fill_in 'payment[paid]', with: 70
    click_button 'Effettua pagamento'
    expect(page).to have_css 'p', text: 'Totale pagamento:70.0'
  end
end
