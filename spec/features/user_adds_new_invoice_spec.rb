require 'rails_helper'

feature 'user' do
  scenario 'Adds a new invoice', js: true do
    company('Bezzi')
    vehicle("ER354BS")
    visit '/companies'
    click_on 'Bezzi'
    click_link 'Aggiungi fattura'
    click_button 'Imponibile'
    fill_in_new_invoice
    click_button 'Aggiungi fattura'
    expect(page).to have_css 'td', text: '305'
    expect(page).to have_css 'td', text: '55'
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
    click_button 'Aggiungi fattura'
    expect(page).to have_css 'td', text: '415'
    expect(page).to have_css 'td', text: '65'
  end

  scenario 'Adds a new invoice with part of the sum already paid', js: true do
    company('Bezzi')
    vehicle("ER354BS")
    visit '/companies'
    click_on 'Bezzi'
    click_link 'Aggiungi fattura'
    click_button 'Due imponibili'
    fill_in_new_invoice
    fill_in 'invoice[paid]', with: 50
    fill_in 'invoice[method_of_payment]', with: "bonifico"
    select '2016', from: 'invoice[payment_date(1i)]'
    select 'March', from: 'invoice[payment_date(2i)]'
    select '1', from: 'invoice[payment_date(3i)]'
    click_button 'Aggiungi fattura'
    click_link 'Manutenzione'
    expect(page).to have_css 'p', text: 'Totale pagamento:50.0'
    expect(page).to have_css 'p', text: 'Metodo pagamento:bonifico'
    expect(page).to have_css 'p', text: 'Data pagamento:01-03-2016'
  end

  scenario 'Adds a new invoice without payment', js: true do
    company('Bezzi')
    vehicle("ER354BS")
    visit '/companies'
    click_on 'Bezzi'
    click_link 'Aggiungi fattura'
    click_button 'Due imponibili'
    fill_in_new_invoice
    click_button 'Aggiungi fattura'
    click_link 'Manutenzione'
    expect(page).not_to have_css 'p', text: 'Pagamenti:'
    expect(page).not_to have_css 'p', text: 'Totale pagamento:'
    expect(page).not_to have_css 'p', text: 'Metodo pagamento:'
    expect(page).not_to have_css 'p', text: 'Data pagamento:'
  end
end
