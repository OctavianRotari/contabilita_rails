require 'rails_helper'

feature 'user' do
  scenario 'user pays part of invoice', js: true do
    sign_up
    create_passive_record('Bezzi',"ER354BS")
    visit('/invoices/1/payments/new')
    fill_in 'payment[paid]', with: 50
    fill_in 'payment[method_of_payment]', with: 'cassa'
    page.execute_script("$('#payment_payment_date').val('2016-05-20')")
    click_button 'Conferma'
    expect(page).to have_css 'p', text: '50.0'
  end
end
