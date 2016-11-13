class InsurancesController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_any?
  before_action :insurance_category_any?
  before_action :insurance_company_any?

  def index
    @companies = current_user_companies.insurances
  end

  def company_insurances
    @insurances = Insurance.where(company_id: params[:id])
  end

  def show
    @insurance = Insurance.find(params[:id])
  end

  def edit
    @insurance = Insurance.find(params[:id])
    @companies = current_user_companies.insurances
    @vehicles = current_user_vehicles
  end

  def update
    build_params = build_insurance
    @insurance = Insurance.find(params[:id])
    @companies = current_user_companies.insurances
    @vehicles = current_user_vehicles
    if @insurance.update(build_params)
      flash[:success] = 'Contratto assicurativo aggiornato'
      redirect_to insurance_path(@insurance.id)
    else
      render 'edit'
    end
  end

  def new
    @insurance = Insurance.new
    @companies = current_user_companies.insurances
    @vehicles = current_user_vehicles
  end

  def create
    build_params = build_insurance
    @insurance = Insurance.new(build_params)
    @companies = current_user_companies.insurances
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
    params.require(:insurance).permit(:total, :at_the_expense_of, :serial_of_contract, :company_id, :description, :deadline, :date_of_issue, :recurrence)
  end

  def insurance_params_user_id
    insurance_params.merge!(user_id: current_user.id)
  end
end
