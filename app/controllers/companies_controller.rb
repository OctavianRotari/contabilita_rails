class CompaniesController < ApplicationController
  before_action :authenticate_user!

  include CheckIfCategoryExists

  def index
    @companies = Company.all
  end

  def new
    if category_exists?
      @category = Category.all
      @company = Company.new
    else
      redirect_to dashboard_companies_path
    end
  end

  def edit
    @company = Company.find(params[:id])
    @category = Category.all
  end

  def update
    @company  = Company.find(params[:id])
    @category = Category.all
    if @company.update(company_params)
      flash[:success] = 'La compania e stata aggiornata'
      redirect_to dashboard_companies_path
    else
      render "edit"
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    flash[:success] = 'Azienda elliminata'
    redirect_to dashboard_companies_path
  end

  def show
    @company = Company.find(params[:company_id] || params[:id])
  end

  def create
    @company = Company.new(company_params)
    @category = Category.all
    @company.category_id = category_id
    if @company.save
      redirect_to dashboard_companies_path
    else
      render "new"
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :adress, :number, :category_id)
  end

  def company
    @_company ||= Company.find(params[:id])
  end

  def category_id
    company_params[:category_id]
  end

end
