require 'rails_helper'

feature 'user' do
  scenario 'updates company' do
    vehicle('ER323ZE')
    visit '/'
    click_link 'Mezzi'
    click_button 'Elimina mezzo'
    expect(page).not_to have_css 'a', text: 'ER323ZE'
  end
end
