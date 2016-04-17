require 'rails_helper'

feature 'user' do
  scenario 'Adds a new invoice', js: true do
    company('Bezzi')
    visit '/companies'
    click_on 'Bezzi'
    click_link 'Aggiungi fattura'
    click_button 'Imponibile'
    fill_in_new_invoice
    click_button 'Aggiungi fattura'
    expect(page).to have_css 'td', text: '305'
    expect(page).to have_css 'td', text: '55'
    expect(page).to have_css 'td', text: 'EG324FR'
  end

  scenario 'Adds a new invoice', js: true do
    company('Bezzi')
    visit '/companies'
    click_on 'Bezzi'
    click_link 'Aggiungi fattura'
    click_button 'Due imponibili'
    fill_in_new_invoice
    fill_in 'invoice[taxable_2]', with: 100
    page.select '10', from: 'invoice[vat_2]'
    click_button 'Aggiungi fattura'
    expect(page).to have_css 'td', text: '415'
    expect(page).to have_css 'td', text: '65'
    expect(page).to have_css 'td', text: 'EG324FR'
  end
end
