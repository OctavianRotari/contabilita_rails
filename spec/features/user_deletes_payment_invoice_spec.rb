require 'rails_helper'

feature 'user' do
  scenario 'deletes payment', js: true do
    invoice = create_passive_record('Bezzi',"ER354BS")
    create_payment(invoice)
    visits_individual_invoice('Bezzi')
    click_button 'Elimina pagamento'
    expect(page).not_to have_css 'p', text: 'Totale pagamento:100.0'
  end
end
