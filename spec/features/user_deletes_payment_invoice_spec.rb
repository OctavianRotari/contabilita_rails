require 'rails_helper'

feature 'user' do
  scenario 'deletes payment', js: true do
    invoice = create_passive_record('Bezzi',"ER354BS")
    create_payment(invoice)
    visits_individual_invoice
    click_button 'Elimina pagamento'
    payments = Payment.all
    expect(payments).to be_empty
  end
end
