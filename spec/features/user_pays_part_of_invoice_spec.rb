require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice' do
    company = company('Bezzi')
    vehicle("ER354BS")
    create_invoice(company)
    visits_individual_invoice
    click_link 'Effettua pagamento'
    fill_in 'payment[paid]', with: 50
    fill_in 'payment[method_of_payment]', with: 'cassa'
    select '2016', from: 'payment[payment_date(1i)]'
    select 'March', from: 'payment[payment_date(2i)]'
    select '1', from: 'payment[payment_date(3i)]'
    click_button 'Effettua pagamento'
    expect(page).to have_css 'p', text: 'Totale pagamento:50.0'
  end
end
