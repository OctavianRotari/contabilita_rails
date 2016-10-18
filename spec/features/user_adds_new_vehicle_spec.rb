require 'rails_helper'

feature 'user' do
  scenario 'adds new vehicle' do
    sign_up
    visit '/vehicles/new'
    fill_in 'vehicle[type_of_vehicle]', with: 'Trattore'
    fill_in 'vehicle[plate]', with: 'ER345BR'
    click_button "Conferma"
    vehicle_plate = Vehicle.first.plate
    expect(vehicle_plate).to eq("ER345BR")
  end
end
