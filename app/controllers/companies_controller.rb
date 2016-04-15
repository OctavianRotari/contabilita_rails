class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
    @company = Company.find(params[:id])
  end

  def create
    company = Company.new(company_params)
    if company.save
      redirect_to company_path(company.id)
    else
      redirect_to company_new_path
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :adress, :number)
  end
end
