require 'rails_helper'

feature 'user' do
  scenario 'updates company' do
    sign_up
    vehicle('ER323ZE')
    visit '/invoices/dashboard'
    visit('/vehicles/dashboard')
    find('.delete-vehicle').click
    vehicles = Vehicle.all
    expect(vehicles).to be_empty
  end
end
