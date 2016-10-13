class CompanyDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do |record|
    if current_user.companies.empty?
      flash[:error] = "Aggiungere almeno un'azienda"
      redirect_to :back
    end
  end

  def index
    @calculator = Calculator.new
    @companies = current_user.companies
  end

  def show
    @calculator = Calculator.new
    @company_dashboard = CompanyDashboard.new(params, current_user)
  end


  def passive_invoices
    @invoices = company_dashboard.passive_invoices
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = company_dashboard.active_invoices
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  private

  def company_dashboard
    CompanyDashboard.new(params, current_user)
  end
end
