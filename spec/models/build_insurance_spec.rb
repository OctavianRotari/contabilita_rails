require 'rails_helper'

describe BuildInsurance, type: :unit do
  let(:general_insurance_params) { attributes_for(:general_insurance) }
  let(:insurance_params) { attributes_for(:insurance) }
  let(:insurance_no_company_params) { attributes_for(:insurance, company_id: nil) }

  before :each do
    create(:user)
    create(:vehicle)
    create(:insurance_category)
    create(:company)
  end

  describe '#build' do
    it 'should set the vehicle id to all nil' do
      build_insurance = BuildInsurance.new(general_insurance_params)
      build_insurance.build
      expect(build_insurance.insurance_params[:at_the_expense_of]).to eq('general_insurance')
    end

    it 'should set the vehicle id' do
      build_insurance = BuildInsurance.new(insurance_params)
      build_insurance.build
      expect(build_insurance.insurance_params[:vehicle_id]).to eq(1)
    end

    it 'should set the category id' do
      build_insurance = BuildInsurance.new(insurance_params)
      build_insurance.build
      expect(build_insurance.insurance_params[:category_id]).to eq(1)
    end

    it 'should set the category id to nil' do
      build_insurance = BuildInsurance.new(insurance_no_company_params)
      build_insurance.build
      expect(build_insurance.insurance_params[:category_id]).to eq(nil)
    end
  end
end
