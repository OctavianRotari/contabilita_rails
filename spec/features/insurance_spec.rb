require 'rails_helper'

feature 'insurance' do
  let(:insurance_category) { create(:insurance_category) }
  let(:insurance_company) { create(:insurance_company) }
  let(:insurance) { create(:insurance) }
  let(:vehicle) { create(:vehicle) }

  before :each do
    create(:user)
    vehicle
    insurance_category
    insurance_company
    sign_in
    insurance
  end

  scenario 'user adds a new insurance contract for vehicle' do
    visit("/insurances/#{insurance.id}")
    expect(page).to have_css '#company_name', text: 'Milano assicurazioni'
    expect(page).to have_css '#serial_of_contract', text: '12321'
    expect(page).to have_css '#total_insurance', text: '1100'
    expect(page).to have_css '#vehicle_plate', text: 'ER354BS'
  end

  scenario 'user sees all the plates insured with a cetain company' do
    vehicle = create(:vehicle, plate: 'BX080PA')
    create(:insurance, vehicle_id: vehicle.id)
    visit('/insurances')
    expect(page).to have_css '#company_name', text: 'Milano assicurazioni'
    expect(page).to have_css '#vehicle_plate', text: 'ER354BS'
    expect(page).to have_css '#vehicle_plate', text: 'BX080PA'
  end

  scenario 'user sees insurance info on the vehicle page' do
    visit("/vehicles/#{vehicle.id}")
    expect(page).to have_css '#insurance_deadline', text: insurance.deadline.strftime("%d-%m-%Y")
    expect(page).to have_css '#insurance_payment_deadline', text: (Time.zone.now + 3.months).strftime("%d-%m-%Y")
  end

  scenario 'user pays the insurence' do
    create(:receipt)
    visit("/insurances/#{insurance.id}")
    expect(page).to have_css '#paid', text: '1100'
    expect(page).to have_css '#policy_number', text: '12'
    expect(page).to have_css '#method_of_payment', text: 'Bonifico'
  end
end
