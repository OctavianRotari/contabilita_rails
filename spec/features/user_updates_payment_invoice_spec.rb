require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice' do
    company = company('Bezzi')
    create_invoice(company)
    visits_individual_invoice
    add_payment
    click_link 'Aggiorna pagamento'
    fill_in 'payment[paid]', with: 70
    click_button 'Effettua pagamento'
    expect(page).to have_css 'p', text: 'Totale pagamento:70.0'
  end
end
