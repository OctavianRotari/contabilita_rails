require 'rails_helper'

feature 'tickets' do
  let(:user) { create(:user) }
  let(:vehicle) { create(:vehicle) }
  let(:ticket) { create(:ticket) }
  let(:administrative_ticket) { create(:administrative_ticket) }

  before :each do
    user
    vehicle
    sign_in
  end

  scenario 'a user adds a vehicle ticket' do
    ticket
    visit("/tickets/vehicle_dashboard?month=#{Time.zone.now.month}&year=#{Time.zone.now.year}")
    expect(page).to have_css '#total_ticket', text: '90'
    expect(page).to have_css '#vehicle_plate', text: 'ER354BS'
    expect(page).to have_css '#not_paid', text: 'Non pagata'
  end

  scenario 'a user adds an administrative ticket' do
    visit('/tickets/new')
    administrative_ticket
    visit("/tickets/administrative_dashboard?month=#{Time.zone.now.month}&year=#{Time.zone.now.year}")
    expect(page).to have_css '#total_ticket', text: '90'
  end

  scenario 'a user adds a vehicle ticket already paid' do
    create(:ticket, paid:true)
    visit("/tickets/vehicle_dashboard?month=#{Time.zone.now.month}&year=#{Time.zone.now.year}")
    expect(page).to have_css '#paid', text: 'Pagata'
  end
end
