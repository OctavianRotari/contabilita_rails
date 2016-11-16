require 'rails_helper'

feature 'general expences' do
  before :each do
    create(:user)
    create(:category)
    create(:company)
    create(:vehicle, charge_general_expenses: true)
    create(:vehicle, charge_general_expenses: true)
    create(:general_expenses_invoice)
  end

  feature 'current_month_costs' do
    before :each do
      create(:general_expenses_invoice, date_of_issue: Time.zone.now - 1.month)
      sign_in
      visit('/general_expenses')
    end

    scenario 'it shows the total general expenses' do
      expect(page).to have_css '#current_month_costs', text: '110'
    end

    scenario 'it shows the total general expences divided per vehicle' do
      expect(page).to have_css '#current_month_costs_per_vehicle', text: '55'
    end
  end

  feature 'current_year_costs' do
    before :each do
      create(:general_expenses_invoice, date_of_issue: Time.zone.now - 1.year)
      sign_in
      visit('/general_expenses')
    end

    scenario 'it shows the total general expenses' do
      expect(page).to have_css '#current_year_costs', text: '110'
      expect(page).to have_css '#current_month_costs', text: '110'
    end

    scenario 'it shows the total general expenses divided per vehicle' do
      expect(page).to have_css '#current_month_costs_per_vehicle', text: '55'
      expect(page).to have_css '#current_year_costs_per_vehicle', text: '55'
    end
  end
end
