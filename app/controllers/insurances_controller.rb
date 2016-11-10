class InsurancesController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_any?
  before_action :insurance_category_any?
  before_action :company_any?

  def show
    @insurance = Insurance.find(params[:id])
  end

  def new
    @insurance = Insurance.new
    @companies = current_user_companies
    @vehicles = current_user_vehicles
  end

  def create
    params = build_insurance
    @insurance = Insurance.new(params)
    @companies = current_user_companies
    @vehicles = current_user_vehicles
    if @insurance.save
      flash[:success] = 'Contratto assicurativo registrato'
      redirect_to insurance_path(@insurance.id)
    else
      render 'new'
    end
  end

  private

  def build_insurance
    BuildInsurance.new(insurance_params_user_id).build
  end

  def insurance_params
    params.require(:insurance).permit(:total, :vehicle_id, :serial_of_contract, :company_id, :deadline, :date_of_issue, :recurrence)
  end

  def insurance_params_user_id
    insurance_params.merge!(user_id: current_user.id)
  end
end
