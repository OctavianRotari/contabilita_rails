require 'rails_helper'

describe BuildInsurance, type: :unit do
  let(:insurance_params) { attributes_for(:insurance, at_the_expense_of: 'all_vehicles') }
  let(:build_insurance) { BuildInsurance.new(insurance_params) }

  describe '#build' do
    it 'should set the vehicle id to all nil' do
      build_insurance.build
      expect(build_insurance.insurance_params[:at_the_expense_of]).to eq('all_vehicles')
    end
  end
end
