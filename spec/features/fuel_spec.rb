require 'rails_helper'

feature 'fuel' do
  scenario 'user adds a new fuel receipt', js: true do
    sign_up
    category('Benzinaio', true)
    company('Esso')
    vehicle("ER354BS")
    visit '/fuel_receipts/new'
    fill_in 'fuel_receipt[total]', with: '300'
    page.select 'Esso', from: 'fuel_receipt[company_id]'
    page.select 'ER354BS', from: 'fuel_receipt[vehicle_id]'
    page.execute_script("$('#fuel_receipt_date_of_issue').val('2016-10-30')")
    click_button 'Conferma'
    expect(page).to have_content '300'
  end
end

