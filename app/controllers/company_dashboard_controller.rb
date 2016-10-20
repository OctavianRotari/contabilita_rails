class CompanyDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do |record|
    if current_user.companies.empty?
      flash[:error] = "Aggiungere almeno un'azienda"
      redirect_to :back
    end
  end

  def index
    @company_dashboard = CompanyDashboard.new(current_user, params)
  end

  def show
    @company_dashboard = CompanyDashboard.new(current_user, params)
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
