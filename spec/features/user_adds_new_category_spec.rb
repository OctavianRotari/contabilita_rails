require 'rails_helper'

feature 'user' do
  scenario 'adds new category' do
    sign_up
    visit '/invoices/dashboard'
    click_link 'Aggiungi categoria'
    fill_in 'category[category]', with: 'Meccanico'
    click_button "Aggiungi categoria"
    category = Category.first.category
    expect(category).to eq "Meccanico"
  end
end
