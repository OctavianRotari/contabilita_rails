require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice' do
    company = company('Bezzi')
    create_invoice(company)
    visits_individual_invoice
    click_link 'Effettua pagamento'
    fill_in 'payment[paid]', with: 50
    fill_in 'payment[method_of_payment]', with: 'cassa'
    fill_in 'payment[payment_date]', with: '05/04/2015'
    click_button 'Effettua pagamento'
    expect(page).to have_css 'p', text: 'Totale pagamento:50.0'
  end
end
