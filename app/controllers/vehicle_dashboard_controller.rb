class VehicleDashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @calculator = Calculator.new
    @vehicles = Vehicle.all
  end

  def show
    @calculator = Calculator.new
    @vehicle_dashboard = VehicleDashboard.new(params)
  end

  def passive_invoices
    @calculator = Calculator.new
    @invoices = vehicle_dashboard.passive_invoices
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @calculator = Calculator.new
    @invoices = vehicle_dashboard.active_invoices
    respond_to do |format|
      format.js
    end
  end

  private

  def vehicle_dashboard
    VehicleDashboard.new(params)
  end

end
