class GarageController < ApplicationController
  before_action :authenticate_user!
  before_action do |record|
    if Vehicle.all.empty?
      flash[:error] = "Aggiungere almeno un mezzo"
      redirect_to :back
    end
  end

  def index
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
    @calculator = Calculator.new
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
