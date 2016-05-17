require 'rails_helper'

feature 'user' do

  context 'passive invoices' do
    before :each do
      create_passive_record('Bezzi', 'ER859BS')
    end

    scenario "user sees all passive invoice's totals", js: true do
      visits_passive_invoices('Bezzi')
      expect(page).to have_css 'tr.totals', text: '110'
      expect(page).to have_css 'tr.totals', text: '10'
    end

    scenario "user sees all passive invoice's totals", js: true do
      create_passive_record('Gionny', 'ER859BS')
      visit_passive_invoices_page
      expect(page).to have_css 'tr.totals', text: '220'
      expect(page).to have_css 'tr.totals', text: '20'
    end
  end

  context 'active invoices' do
    before :each do
      create_active_record('Bezzi', 'ER859BS')
    end

    scenario "user sees all active invoice's totals", js: true do
      visits_active_invoices('Bezzi')
      expect(page).to have_css 'tr.totals', text: '110'
      expect(page).to have_css 'tr.totals', text: '10'
    end

    scenario "user sees all active invoice's totals", js: true do
      create_active_record('Gionny', 'ER859BS')
      visit_active_invoices_page
      expect(page).to have_css 'tr.totals', text: '220'
      expect(page).to have_css 'tr.totals', text: '20'
    end
  end
end
