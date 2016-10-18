require 'rails_helper'

feature 'user' do
  scenario 'deletes payment', js: true do
    sign_up
    invoice = create_passive_record('Bezzi',"ER354BS")
    create_payment(invoice)
    visit('/invoices/1')
    click_link 'Elimina pagamento.'
    expect(page).not_to have_css 'p', text: 'cassa'
  end
end
