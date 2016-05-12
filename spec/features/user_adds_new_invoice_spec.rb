require 'rails_helper'

feature 'user' do
  scenario 'adds a new invoice', js: true do
    company('Bezzi')
    vehicle("ER354BS")
    visit '/companies'
    click_on 'Bezzi'
    click_link 'Aggiungi fattura'
    click_button 'Imponibile'
    fill_in_new_invoice
    click_button 'Conferma'
    expect(page).to have_css 'h2', text: 'Manutenzione'
  end

  scenario 'Adds a new invoice with two taxable', js: true do
    company('Bezzi')
    vehicle("ER354BS")
    visit '/companies'
    click_on 'Bezzi'
    click_link 'Aggiungi fattura'
    click_button 'Due imponibili'
    fill_in_new_invoice
    fill_in 'invoice[taxable_2]', with: 100
    page.select '10', from: 'invoice[vat_2]'
    click_button 'Conferma'
    expect(page).to have_css 'p', text: '415'
    expect(page).to have_css 'p', text: '65'
  end

end
