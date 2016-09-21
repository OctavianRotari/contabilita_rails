require 'rails_helper'

feature 'user' do
  scenario 'sees active invoices for a specific vehicle', js: true do
    company = company('Bezzi')
    vehicle('RB342BD')
    create_passive_invoice(company,'Montaggio gomme')
    visits_passive_invoices("Mezzi")
    expect(page).to have_css 'td', text: 'Montaggio gomme'
  end

  scenario 'sees the amout it has to be paid for the company' do
    create_passive_record('Bezzi',"ER354BS")
    sign_up
    visit '/invoices/dashboard'
    click_link "Mezzi"
    expect(page).to have_css 'p#passive_amont_to_pay_per_vehicle', text: '110'
  end

  scenario 'sees the amout it has to be collected for the company' do
    create_active_record('Bezzi',"ER354BS")
    sign_up
    visit '/invoices/dashboard'
    click_link "Mezzi"
    expect(page).to have_css 'p#active_amout_to_collect_per_vehicle', text: '110'
  end


  scenario 'sees the costs for the vehicle for the current month' do
    create_passive_record('Bezzi',"ER354BS")
    company = Company.first
    create_passive_invoice_different_date(company, "2016-08-21 10:02:38")
    sign_up
    visit '/invoices/dashboard'
    click_link "Mezzi"
    expect(page).to have_css 'p#current_month_costs', text: '110'
  end

  scenario 'sees the costs for the vehicle for the current year' do
    create_passive_record('Bezzi',"ER354BS")
    company = Company.first
    create_passive_invoice_different_date(company, "2015-08-21 10:02:38")
    sign_up
    visit '/invoices/dashboard'
    click_link "Mezzi"
    expect(page).to have_css 'p#current_year_costs', text: '110'
  end
end
