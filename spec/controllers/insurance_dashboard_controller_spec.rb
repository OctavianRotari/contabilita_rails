require 'rails_helper'

describe InsuranceDashboardController, type: :controller do
  sign_in_user

  let(:insurance_category) { create(:insurance_category) }
  let(:insurance_company) { create(:company, name: 'Milano', category_id: insurance_category.id) }

  before :each do
    create(:vehicle)
    request.env["HTTP_REFERER"] = 'where_i_came_from'
  end

  it 'returns a collection of insurances' do
    get :company_insurances, id: insurance_company.id
    expect(response.status).to eq(200)
  end

  it 'returns a collection of insurances' do
    get :category_insurances, id: insurance_company.id
    expect(response.status).to eq(200)
  end
end
