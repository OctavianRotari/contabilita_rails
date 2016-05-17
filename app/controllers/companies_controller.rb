class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    company  = Company.find(params[:id])
    company.update(company_params)
    redirect_to companies_path
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    flash[:notice] = 'Azienda elliminata'
    redirect_to companies_path
  end

  def show
    @company = Company.find(params[:company_id] || params[:id])
  end

  def passive_invoices
    @invoices = Company.find(params[:company_id]).invoices.passive
    @invoices_month = @invoices.group_by { |t| t.date_of_issue.beginning_of_month }
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = Company.find(params[:company_id]).invoices.active
    @invoices_month = @invoices.group_by { |t| t.date_of_issue.beginning_of_month }
    respond_to do |format|
      format.js
    end
  end

  def create
    company = Company.new(company_params)
    if company.save
      redirect_to companies_path
    else
      redirect_to company_new_path
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :adress, :number)
  end
end
