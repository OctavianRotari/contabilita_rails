require 'rails_helper'

feature 'general expences' do
  before :each do
    create(:user)
    create(:category)
    create(:company)
    create(:vehicle, charge_general_expences: true)
    sign_in
  end

  feature 'current_month_costs' do
    scenario 'it shows the total general expences' do
      create(:invoice)
    end
  end
end
