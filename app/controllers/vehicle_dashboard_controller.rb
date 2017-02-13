class VehicleDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_any?

  def index
    @vehicle_dashboard = VehicleDashboard.new(current_user, params)
  end

  def show
    @vehicle_dashboard = VehicleDashboard.new(current_user, params)
  end

  def passive_invoices
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  private

  def vehicle_id
    params[:id]
  end
end
