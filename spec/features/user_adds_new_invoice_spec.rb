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
    visit_invoice_page
    click_link 'Aggiungi Fattura'
  end
end
