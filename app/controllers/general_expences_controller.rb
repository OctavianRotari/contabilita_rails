class GeneralExpencesController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_general_expences_any?

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
