require 'rails_helper'

feature 'companies' do
  let(:company) { create(:company) }
  let(:insurance_category) { create(:insurance_category) }
  let(:insurance_company) { create(:insurance_company) }

  before :each do
    create(:user)
    create(:vehicle)
  end

  feature 'company already exists' do
    before :each do
      create(:category)
      sign_in
      company
      visit('/companies/dashboard')
    end

    scenario 'user can see the plate of the new company' do
      expect(page).to have_css '#company_name', text: company.name
    end

    scenario 'deletes company' do
      find('.delete-company').click
      expect(page).not_to have_css '#company_name', text: company.name
    end

    scenario "visits company's invoices" do
      find('#invoices').click
      expect(page).to have_content('Esso')
    end

    feature 'and has invoices' do
      before :each do
        create(:invoice, type_of_invoice: 'passiva')
        create(:invoice)
        visit '/companies/dashboard'
      end

      scenario 'passive_amont_to_pay for the company' do
        expect(page).to have_css '#passive_amont_to_pay', text: '110'
      end

      scenario 'active_amout_to_collect for the company' do
        expect(page).to have_css '#active_amout_to_collect', text: '110'
      end

      scenario 'sees the costs for the company for the current month' do
        create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.month)
        expect(page).to have_css '#current_month_costs', text: '110'
      end

      scenario 'sees the costs for the company for the current year' do
        create(:invoice, type_of_invoice: 'passiva', date_of_issue: Time.zone.now - 1.year)
        expect(page).to have_css '#current_year_costs', text: '110'
      end
    end
  end
end
