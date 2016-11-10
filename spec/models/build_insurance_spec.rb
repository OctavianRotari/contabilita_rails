require 'rails_helper'

describe BuildInsurance, type: :unit do
  let(:insurance_params) { attributes_for(:insurance, vehicle_id: 'all_vehicles') }
  let(:build_insurance) { BuildInsurance.new(insurance_params) }

  describe '#build' do
    it 'should set the vehicle id to all nil' do
      build_insurance.build
      expect(build_insurance.insurance_params[:at_the_expense_of]).to eq('Tutti i mezzi')
    end
  end
end
