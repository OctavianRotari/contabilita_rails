class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :category_any?

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
    redirect_after_destroy(current_user_companies)
  end

  def show
    @company = Company.find(params[:company_id] || params[:id])
  end

  def create
    @company = Company.new(company_params_user_id)
    @category = current_user_categories
    if @company.save
      flash[:success] = 'Azienda aggiunta'
      redirect_to dashboard_companies_path
    else
      render 'new'
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :adress, :number, :category_id)
  end

  def company_params_user_id
    company_params.merge!(user_id: current_user[:id])
  end

  def company
    @_company ||= Company.find(params[:id])
  end

  def category_id
    company_params[:category_id]
  end
end
