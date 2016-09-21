require 'rails_helper'

feature 'user' do
  scenario 'deletes company' do
    category
    company('Bezzi')
    sign_up
    visit '/invoices/dashboard'
    click_link 'Aziende'
    click_button 'Elimina azienda'
    companies = Company.all
    expect(companies).to be_empty
  end
end
