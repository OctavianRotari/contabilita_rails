require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice', js: true do
    company = company('Bezzi')
    vehicle("ER354BS")
    create_invoice(company)
    visits_individual_invoice
    click_link 'Effettua pagamento'
    fill_in 'payment[paid]', with: 50
    fill_in 'payment[method_of_payment]', with: 'cassa'
    page.execute_script("$('#payment_payment_date').val('2016-05-20')")
    click_button 'Effettua pagamento'
    expect(page).to have_css 'p', text: 'Totale pagamento:50.0'
  end
end
