require 'rails_helper'

feature 'user' do
  scenario 'updates company' do
    vehicle('ER323ZE')
    sign_up
    visit '/invoices/dashboard'
    click_link 'Mezzi'
    click_button 'Elimina mezzo'
    vehicles = Vehicle.all
    expect(vehicles).to be_empty
  end
end
