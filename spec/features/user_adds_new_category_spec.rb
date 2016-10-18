require 'rails_helper'

feature 'user' do
  scenario 'adds new category' do
    sign_up
    visit '/categories/new'
    fill_in 'category[category]', with: 'Meccanico'
    click_button "Conferma"
    category = Category.first.category
    expect(category).to eq "Meccanico"
  end
end
