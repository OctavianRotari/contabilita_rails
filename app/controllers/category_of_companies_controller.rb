class CategoryOfCompaniesController < ApplicationController

  def new
    @category_of_company = CategoryOfCompany.new
  end

  def edit
    @category_of_company = CategoryOfCompany.find(params[:id])
  end

  def update
    category_of_company = CategoryOfCompany.find(params[:id])
    if category_of_company.update(category_params)
      redirect_to dashboard_companies_path
    else
      flash[:notice] = 'La modifica non e andata a buon fine controllare i dati inseriti'
      redirect_to edit_category_of_company_path(params[:id])
    end
  end

  def create
    @category_of_company = CategoryOfCompany.new(category_params)
    if @category_of_company.save
      redirect_to dashboard_companies_path
    else
      render new_category_of_company_path
    end
  end

  private

  def category_params
    params.require(:category_of_company).permit(:category)
  end

end
