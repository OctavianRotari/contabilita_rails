require 'rails_helper'

feature 'user' do
  scenario 'user sees individual invoice', js: true do
    create_passive_record('Bezzi',"ER859BS")
    visits_individual_invoice('Bezzi')
    expect(page).to have_css 'h2', text: 'Manutenzione'
    expect(page).to have_css 'p', text: 'Imponibile: 100'
  end
end
