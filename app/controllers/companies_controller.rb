class CompaniesController < ApplicationController
  include CheckIfCategoryOfCompanyExists
  include CreateCategoryOfCompany

  def index
    @companies = Company.all
  end

  def new
    if category_of_company_exists?
      @category_of_companies = CategoryOfCompany.all
      @company = Company.new
      @category_of_company = CategoryOfCompany.new
      if params[:commit] == 'Aggiungi categoria'
        category_of_company
      end
    else
      redirect_to dashboard_companies_path
    end
  end

  def edit
    @company = Company.find(params[:id])
    @category_of_companies = CategoryOfCompany.all
    @category_of_company = CategoryOfCompany.new
    if params[:commit] == 'Aggiungi categoria'
      category_of_company
    end
  end

  def update
    company  = Company.find(params[:id])
    if company.update(company_params)
      redirect_to dashboard_companies_path
    else
      flash[:notice] = 'La modifica non e andata a buon fine controllare i dati inseriti'
      redirect_to edit_company_path(params[:id])
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    flash[:notice] = 'Azienda elliminata'
    redirect_to dashboard_companies_path
  end

  def show
    @company = Company.find(params[:company_id] || params[:id])
  end

  def create
    @company = Company.new(company_params)
    @category_of_companies = CategoryOfCompany.all
    @category_of_company = CategoryOfCompany.new
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

  def category_params
    params.require(:category_of_company).permit(:category)
  end
end
