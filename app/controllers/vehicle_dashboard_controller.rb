class VehicleDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do |record|
    if current_user.vehicles.empty?
      flash[:error] = "Aggiungere almeno un mezzo"
      redirect_to :back
    end
  end

  def index
    @vehicle_dashboard = VehicleDashboard.new(params, current_user)
  end

  def show
    @vehicle_dashboard = VehicleDashboard.new(params, current_user)
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
end
