class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    if current_user.categories.empty?
      flash[:error] = 'Aggiungere almeno una categoria'
      redirect_to :back
    end
  end

  def index
    @companies = current_user.companies
  end

  def new
    @category = current_user.categories
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
    @category = current_user.categories
  end

  def update
    @company  = Company.find(params[:id])
    @category = current_user.categories
    if @company.update(company_params)
      flash[:success] = 'Azienda aggiornata'
      redirect_to dashboard_companies_path
    else
      render 'edit'
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    flash[:success] = 'Azienda elliminata'
    if current_user.companies.count > 0
      redirect_to :back
    else
      redirect_to dashboard_invoices_path
    end
  end

  def show
    @company = Company.find(params[:company_id] || params[:id])
  end

  def create
    @company = Company.new(company_params)
    @category = current_user.categories
    @company[:user_id] = current_user[:id]
    @company[:category_id] = category_id
    if @company.save
      redirect_to dashboard_companies_path
    else
      render 'new'
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
