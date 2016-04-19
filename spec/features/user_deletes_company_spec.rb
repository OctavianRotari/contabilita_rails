require 'rails_helper'

feature 'user' do
  scenario 'updates company' do
    company('Bezzi')
    visit '/'
    click_link 'Aziende'
    click_button 'Elimina azienda'
    expect(page).not_to have_css 'a', text: 'Bezzi'
  end
end
