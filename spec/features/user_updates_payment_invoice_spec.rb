require 'rails_helper'

feature 'user' do
  scenario 'updates a payment', js: true do
    sign_up
    invoice = create_passive_record('Bezzi',"ER354BS")
    create_payment(invoice)
    visit '/invoices/1/payments/1/edit'
    fill_in 'payment[paid]', with: 70
    click_button 'Conferma'
    expect(page).to have_css 'p', text: '70.0'
  end
end
