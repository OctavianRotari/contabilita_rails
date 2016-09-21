require 'rails_helper'

feature 'user' do
  scenario 'deletes invoice', js: true do
    sign_up
    create_passive_record('Bezzi',"ER354BS")
    visit '/invoices/dashboard'
    click_button "Elimina fattura"
    invoices = Invoice.all
    expect(invoices).to be_empty
  end
end
