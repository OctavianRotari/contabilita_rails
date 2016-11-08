require 'rails_helper'

feature 'categories' do
  let(:category) { create(:category) }

  before :each do
    create(:user)
    category
    sign_in
    create(:company)
    visit('/categories/dashboard')
  end

  feature 'adds a new category' do
    scenario 'user can see the plate of the new category' do
      expect(page).to have_css '#category_name', text: category.name
    end
  end

  feature 'category already exists' do
    before :each do
      visit('/categories/dashboard')
    end

    scenario 'deletes category' do
      find('.delete-category').click
      expect(page).not_to have_css '#category_name', text: category.name
    end


    feature 'and has invoices' do
      before :each do
        create(:vehicle)
        create(:invoice, type_of_invoice: 'passiva')
        create(:invoice)
        visit '/categories/dashboard'
      end

      scenario "visits company's invoices" do
        find('.invoices').click
        expect(page).to have_content('Benzinaio')
      end

      scenario 'passive_amont_to_pay for the category' do
        expect(page).to have_css '#passive_amont_to_pay', text: '110'
      end

      scenario 'active_amout_to_collect for the category' do
        expect(page).to have_css '#active_amout_to_collect', text: '110'
      end

      scenario 'sees the costs for the category for the current month' do
        create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.month)
        expect(page).to have_css '#current_month_costs', text: '110'
      end

      scenario 'sees the costs for the category for the current year' do
        create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.year)
        expect(page).to have_css '#current_year_costs', text: '110'
      end
    end
  end
end
