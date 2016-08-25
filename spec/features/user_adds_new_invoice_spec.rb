require 'rails_helper'

feature 'user' do

  scenario 'cant add a new invoice if there is no companies', js: true do
    vehicle("ER354BS")
    visit '/'
    click_link 'Aggiungi fattura'
    expect(current_path).to eq root_path
    expect(page).to have_content "Aggiungere almeno un'azienda"
  end

  scenario 'cant add a new invoice if there is no vehicles', js: true do
    company('Bezzi')
    visit '/'
    click_link 'Aggiungi fattura'
    expect(current_path).to eq root_path
    expect(page).to have_content "Aggiungere almeno un mezzo"
  end

  scenario 'adds a new invoice', js: true do
    company('Bezzi')
    vehicle("ER354BS")
    visit '/'
    click_link 'Aggiungi fattura'
    fill_in_new_invoice
    click_button 'Conferma'
    expect(page).to have_css 'h2', text: 'Manutenzione'
  end

  scenario 'adds a new invoice with two taxable', js: true do
    company('Bezzi')
    vehicle("ER354BS")
    visit '/'
    click_link 'Aggiungi fattura'
    click_link 'Aggiungi imponibile'
    fill_in_new_invoice
    fill_in 'invoice[taxable_vat_fields_attributes][1][taxable]', with: 100
    page.select '10', from: 'invoice[taxable_vat_fields_attributes][1][vat_rate]'
    click_button 'Conferma'
    expect(page).to have_css 'p', text: '415'
    expect(page).to have_css 'p', text: '65'
  end

end
