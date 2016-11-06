require 'rails_helper'

feature 'user' do
  before :each do
    create(:user)
    create(:vehicle)
    create(:category)
    create(:company)
    sign_in
  end

  feature 'passive invoices not paid' do
    before :each do
      create(:invoice, type_of_invoice: 'passiva')
    end

    scenario 'sees unpaid invoices' do
      visit '/invoices/dashboard'
      expect(page).to have_css '#supplier_1', text: 'Esso'
      expect(page).to have_css '#total_1', text: '110'
    end

    scenario 'sees totals unpaid invoices' do
      create(:invoice, type_of_invoice: 'passiva')
      create(:payment)
      visit '/invoices/dashboard'
      expect(page).to have_css '.total', text: '220'
      expect(page).to have_css '.vat', text: '20'
      expect(page).to have_css '.paid', text: '0'
      expect(page).to have_css '.to_pay', text: '120'
    end
  end

  feature 'passive invoices paid' do
    scenario 'does not see paid invoices' do
      create(:invoice, type_of_invoice: 'passiva', paid: true)
      visit '/invoices/dashboard'
      expect(page).to_not have_css '#supplier_1', text: 'Esso'
      expect(page).to_not have_css '#total_1', text: '110'
    end
  end

  feature 'active invoices not collected' do
    before :each do
      create(:invoice)
    end

    scenario 'sees uncollected invoices' do
      visit '/invoices/dashboard'
      expect(page).to have_css '#supplier_1', text: 'Esso'
      expect(page).to have_css '#total_1', text: '110'
    end

    scenario 'sees totals uncollected invoices' do
      create(:payment)
      create(:invoice)
      visit '/invoices/dashboard'
      expect(page).to have_css '.total', text: '220'
      expect(page).to have_css '.vat', text: '20'
      expect(page).to have_css '.paid', text: '0'
      expect(page).to have_css '.to_pay', text: '120'
    end
  end

  feature 'active invoices collected' do
    scenario 'does not see collected invoices' do
      create(:invoice, paid: true)
      expect(page).to_not have_css '#supplier_1', text: 'Esso'
      expect(page).to_not have_css '#total_1', text: '110'
    end
  end
end
