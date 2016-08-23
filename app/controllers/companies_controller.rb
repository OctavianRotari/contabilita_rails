class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def new
    @category_of_company = CategoryOfCompany.all
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
    @category_of_company = CategoryOfCompany.all
  end

  def update
    @category_of_company = CategoryOfCompany.all
    company  = Company.find(params[:id])
    company.update(company_params)
    redirect_to companies_path
  end

  def destroy
    @company = Company.find(params[:id])
    company.destroy
    flash[:notice] = 'Azienda elliminata'
    redirect_to companies_path
  end

  def show
    @company = Company.find(params[:company_id] || params[:id])
  end

  def create
    @company = Company.new(company_params)
    @category_of_company = CategoryOfCompany.all
    if @company.save
      redirect_to companies_path
    else
      render new_company_path
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :adress, :number)
  end

  def company
    @_company ||= Company.find(params[:id])
  end
end
