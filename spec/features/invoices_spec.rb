require 'rails_helper'

feature 'user' do
  let(:passive_invoice) { create(:passive_invoice) }
  let(:active_invoice) { create(:invoice) }

  before :each do
    create(:user)
    create(:vehicle)
    create(:category)
    create(:company)
    sign_in
  end

  feature 'passive_invoices' do
    before :each do
      passive_invoice
      active_invoice
      visit_passive_invoices_page
    end

    scenario 'user adds new passive invoice' do
      expect(page).to have_css '#supplier_1', text: 'Esso'
      expect(page).to have_css '#total_1', text: '110'
    end

    scenario 'sees totals unpaid invoices' do
      expect(page).to have_css '.total', text: '110'
      expect(page).to have_css '.vat', text: '10'
      expect(page).to have_css '.paid', text: '0'
      expect(page).to have_css '.to_pay', text: '110'
    end
  end

  feature 'active_invoice' do
    before :each do
      passive_invoice
      active_invoice
      visit_active_invoices_page
    end

    scenario 'sees uncollected invoices' do
      expect(page).to have_css '#supplier_1', text: 'Esso'
      expect(page).to have_css '#total_1', text: '110'
    end

    scenario 'sees totals uncollected invoices' do
      expect(page).to have_css '.total', text: '110'
      expect(page).to have_css '.vat', text: '10'
      expect(page).to have_css '.paid', text: '0'
      expect(page).to have_css '.to_pay', text: '110'
    end
  end
end
