require 'rails_helper'

feature 'user' do

  scenario 'sees the costs for the vehicle for the current month' do
    sign_up
    create_passive_record('Bezzi',"ER354BS")
    company = Company.first
    create_passive_invoice_different_date(company, "2016-08-21 10:02:38")
    visit 'vehicles/dashboard'
    expect(page).to have_css 'p#current_month_costs', text: '110'
  end

  scenario 'sees the costs for the vehicle for the current year' do
    sign_up
    create_passive_record('Bezzi',"ER354BS")
    company = Company.first
    create_passive_invoice_different_date(company, "2015-08-21 10:02:38")
    visit 'vehicles/dashboard'
    expect(page).to have_css 'p#current_year_costs', text: '110'
  end
end
