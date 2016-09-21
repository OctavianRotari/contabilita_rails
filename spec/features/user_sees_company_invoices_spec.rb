require 'rails_helper'

feature 'user clicks on the company' do 
  scenario 'sees all passive invoices of that particular company', js: true do
    category
    company = company('Bezzi')
    vehicle("ER859BS")
    create_passive_invoice(company,'Montaggio gomme')
    create_passive_invoice(company)
    visits_passive_invoices("Aziende")
    expect(page).to have_css 'td', text: 'Manutenzione'
    expect(page).to have_css 'td', text: 'Montaggio gomme'
  end


  scenario 'sees the amout it has to be paid for the category' do
    create_passive_record('Bezzi',"ER354BS")
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#passive_amount_to_pay', text: '110'
  end


  scenario 'sees that the amout is changing if a part is paid' do
    invoice = create_passive_record('Bezzi',"ER354BS")
    create_payment(invoice)
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#passive_amount_to_pay', text: '10'
  end

  scenario 'sees the amout it has to be collected for the category' do
    create_active_record('Bezzi',"ER354BS")
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#active_amount_to_collect', text: '110'
  end

  scenario 'sees that the amout is changing if a part is collected' do
    invoice = create_active_record('Bezzi',"ER354BS")
    create_payment(invoice)
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#active_amount_to_collect', text: '10'
  end

  scenario 'sees the costs for the current month' do
    create_passive_record('Bezzi',"ER354BS")
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#current_month_costs', text: '110'
  end

  scenario 'sees the amout it has to be paid for the company' do
    create_passive_record('Bezzi',"ER354BS")
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#passive_amont_to_pay_per_company', text: '110'
  end

  scenario 'sees the amout it has to be collected for the company' do
    create_active_record('Bezzi',"ER354BS")
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#active_amout_to_collect_per_company', text: '110'
  end


  scenario 'sees the costs for the category for the current month' do
    create_passive_record('Bezzi',"ER354BS")
    company = Company.first
    create_passive_invoice_different_date(company, "2016-08-21 10:02:38")
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#current_month_costs', text: '110'
  end

  scenario 'sees the costs for the category for the current year' do
    create_passive_record('Bezzi',"ER354BS")
    company = Company.first
    create_passive_invoice_different_date(company, "2015-08-21 10:02:38")
    sign_up
    visit '/invoices/dashboard'
    click_link "Aziende"
    expect(page).to have_css 'p#current_year_costs', text: '110'
  end
end
