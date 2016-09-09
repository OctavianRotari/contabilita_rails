class CategoryOfCompaniesController < ApplicationController
  before_action :authenticate_user!

  def new
    @category_of_company = CategoryOfCompany.new
  end

  def edit
    @category_of_company = CategoryOfCompany.find(params[:id])
  end

  def update
    @category_of_company = CategoryOfCompany.find(params[:id])
    if @category_of_company.update(category_params)
      flash[:notice] = 'Categoria modificata'
      redirect_to dashboard_companies_path
    else
      render "edit"
    end
  end

  def create
    @category_of_company = CategoryOfCompany.new(category_params)
    if @category_of_company.save
      flash[:notice] = "Categoria aggiunta"
      redirect_to dashboard_companies_path
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:category_of_company).permit(:category)
  end

end
