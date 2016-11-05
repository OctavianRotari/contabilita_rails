class CategoryDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :category_any?

  def index
    @category_dashboard = CategoryDashboard.new(params, current_user)
  end

  def show
    @category_dashboard = CategoryDashboard.new(params, current_user)
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
