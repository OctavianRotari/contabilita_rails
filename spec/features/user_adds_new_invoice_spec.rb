require 'rails_helper'

feature 'user' do
  scenario 'visits page new invoice' do
    company = company('Bezzi')
    create_record(company)
    visit '/'
    click_link 'Aziende'
    click_link 'Bezzi'
    click_link 'Aggiungi fattura'
    expect(page).to have_css 'h2', text: 'Aggiungi Fattura'
  end

  scenario 'Adds a new invoice' do
    company = company('Bezzi')
    visit '/'
    click_link 'Aziende'
    click_link 'Bezzi'
    click_link 'Aggiungi fattura'
    fill_in 'invoice[total]', with: 250
    fill_in 'invoice[date]', with: "01/04/2015"
    fill_in 'invoice[plate]', with: "EG324FR"
    fill_in 'invoice[deadline]', with: "01/05/2015"
    fill_in 'invoice[type_of_payment]', with: "bonifico"
    click_button 'Aggiungi fattura'
    expect(page).to have_css 'td', text: '250'
    expect(page).to have_css 'td', text: 'EG324FR'
    expect(page).to have_css 'td', text: 'bonifico'
  end
end
