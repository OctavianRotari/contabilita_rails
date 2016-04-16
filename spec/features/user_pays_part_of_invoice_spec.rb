require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice' do
    company = company('Bezzi')
    create_record(company)
    visits_individual_invoice
    click_link 'Effettua pagamento'
    fill_in 'payment[total]', with: 50
    fill_in 'payment[method_of_payment]', with: 'cassa'
    fill_in 'payment[date]', with: '05/04/2015'
    click_button 'Effettua pagamento'
    expect(page).to have_css 'p', text: 'Totale pagamento:50'
  end
end