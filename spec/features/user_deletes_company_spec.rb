require 'rails_helper'

feature 'user' do
  scenario 'deletes company' do
    sign_up
    category
    company('Bezzi')
    visit '/companies/dashboard'
    find('.delete-company').click
    companies = Company.all
    expect(companies).to be_empty
  end
end
