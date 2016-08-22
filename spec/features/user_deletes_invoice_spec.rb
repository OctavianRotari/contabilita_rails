require 'rails_helper'

feature 'user' do
  scenario 'deletes invoice', js: true do
    create_passive_record('Bezzi',"ER354BS")
    visits_passive_invoices("Aziende")
    click_button "Elimina fattura"
    expect(page).not_to have_css 'td', text: 'Manutenzione'
  end
end
