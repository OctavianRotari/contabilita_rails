class CompaniesController < ApplicationController
  include CheckIfCategoryOfCompanyExists

  def index
    @companies = Company.all
  end

  def new
    if category_of_company_exists?
      @category_of_company = CategoryOfCompany.all
      @company = Company.new
    else
      redirect_to dashboard_companies_path
    end
  end

  def edit
    @company = Company.find(params[:id])
    @category_of_company = CategoryOfCompany.all
  end

  def update
    @category_of_company = CategoryOfCompany.all
    @company  = Company.find(params[:id])
    if company.update(company_params)
      redirect_to dashboard_companies_path
    else
      redirect_to edit_company_path(@company.id)
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = 'Azienda elliminata'
    redirect_to dashboard_companies_path
  end

  def show
    @company = Company.find(params[:company_id] || params[:id])
  end

  def create
    @company = Company.new(company_params)
    @category_of_company = CategoryOfCompany.all
    @company.category_of_company_id = category_of_company_id
    if @company.save
      redirect_to dashboard_companies_path
    else
      render new_company_path
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :adress, :number, :category_of_company_id)
  end

  def company
    @_company ||= Company.find(params[:id])
  end

  def category_of_company_id
    company_params[:category_of_company_id]
  end
end
