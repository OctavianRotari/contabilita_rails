require 'rails_helper'

feature 'user' do
  scenario 'sees unpaid invoices' do
    sign_up
    category
    create_passive_record('Bezzi', 'ER859BS')
    visit '/invoices/dashboard'
    expect(page).to have_css 'td', text: 'Bezzi'
    expect(page).to have_css 'td', text: '110'
  end


  scenario "doesn't see paid invoices" do
    sign_up
    category
    invoice = create_passive_record('Giovanni', 'ER859BS')
    create_payment(invoice, 110)
    visit '/invoices/dashboard'
    expect(page).to_not have_css 'td', text: 'Giovanni'
    expect(page).to_not have_css 'td', text: '110'
  end

  scenario 'sees uncollected invoices' do
    sign_up
    category
    create_active_record('Bezzi', 'ER859BS')
    visit '/invoices/dashboard'
    expect(page).to have_css 'td', text: 'Bezzi'
    expect(page).to have_css 'td', text: '110'
  end


  scenario "doesn't see collected invoices" do
    sign_up
    category
    invoice = create_active_record('Giovanni', 'ER859BS')
    create_payment(invoice, 110)
    visit '/invoices/dashboard'
    expect(page).to_not have_css 'td', text: 'Giovanni'
    expect(page).to_not have_css 'td', text: '110'
  end
end
