require 'rails_helper'

feature 'user' do
  scenario 'adds new company' do
    visit '/'
    click_link 'Aziende'
    click_link 'Aggiungi azienda'
    fill_in 'company[name]', with: 'Bezzi'
    fill_in 'company[adress]', with: 'Ravenna Bagnacavallo'
    fill_in 'company[number]', with: '0293-143352'
    click_button "Aggiungi azienda"
    expect(page).to have_css 'a', text: 'Bezzi'
  end

  scenario 'user cant add company with the same name' do
    company("Bezzi")
    visit '/'
    click_link 'Aziende'
    click_link 'Aggiungi azienda'
    fill_in 'company[name]', with: 'Bezzi'
    fill_in 'company[adress]', with: 'Ravenna Bagnacavallo'
    fill_in 'company[number]', with: '0293-143352'
    click_button "Aggiungi azienda"
    expect(page).to have_content "Azienda con questo nome gia registrata"
  end

  scenario 'cant add a new company if fields are not filled' do
    visit '/'
    click_link 'Aziende'
    click_link 'Aggiungi azienda'
    click_button "Aggiungi azienda"
    expect(page).to have_content "Inserire nome dell'azienda"
    expect(page).to have_content "Inserire numero telefonico dell'azienda"
    expect(page).to have_content "Inserire indirizzo dell'azienda"
  end
end
