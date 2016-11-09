class InsurancesController < ApplicationController
  def new
    @insurance = Insurance.new
    @companies = current_user_companies
    @vehicles = current_user_vehicles
  end

  def create
    render 'new'
  end
end
