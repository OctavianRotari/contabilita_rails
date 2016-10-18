require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice', js: true do
    sign_up
    create_passive_record('Bezzi',"ER859BS")
    visit('/invoices/1')
    expect(page).to have_css 'h3', text: 'Manutenzione'
    expect(page).to have_css 'p', text: '100'
  end
end
