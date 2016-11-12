require 'rails_helper'

feature 'general expences' do
  before :each do
    create(:user)
    create(:category)
    create(:company)
    create(:vehicle, charge_general_expences: true)
    create(:vehicle, charge_general_expences: true)
    create(:invoice, type_of_invoice: 'passiva', at_the_expense_of: 'Spese generali', vehicle_id: nil)
  end

  feature 'current_month_costs' do
    before :each do
      create(:invoice, type_of_invoice: 'passiva',
             at_the_expense_of: 'Spese generali',
             vehicle_id: nil,
             date_of_issue: Time.zone.now - 1.month)
      sign_in
      visit('/general_expences')
    end

    scenario 'it shows the total general expences' do
      expect(page).to have_css '#current_month_costs', text: '110'
    end

    scenario 'it shows the total general expences divided per vehicle' do
      expect(page).to have_css '#current_month_costs_per_vehicle', text: '55'
    end
  end

  feature 'current_year_costs' do
    before :each do
      create(:invoice, type_of_invoice: 'passiva',
             at_the_expense_of: 'general_expences',
             vehicle_id: nil,
             date_of_issue: Time.zone.now - 1.year)
      sign_in
      visit('/general_expences')
    end

    scenario 'it shows the total general expences' do
      expect(page).to have_css '#current_month_costs', text: '110'
    end

    scenario 'it shows the total general expences divided per vehicle' do
      expect(page).to have_css '#current_month_costs_per_vehicle', text: '55'
    end
  end
end
