class CategoryDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do |record|
    if current_user.categories.empty?
      flash[:error] = "Aggiungere almeno una categoria"
      redirect_to :back
    end
  end

  def index
    @calculator = Calculator.new
    @categories = current_user.categories
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
  end

  def show
    @calculator = Calculator.new
    @category_dashboard = CategoryDashboard.new(params, current_user)
    @invoices_dashboard = InvoiceDashboard.new(current_user, params)
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
