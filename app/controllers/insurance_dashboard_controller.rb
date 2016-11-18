class InsuranceDashboardController < ApplicationController
  def company_insurances
    @company = Company.find(params[:id])
    @insurances = Insurance.where(company_id: params[:id])
  end

  def category_insurances
    id = params[:id]
    @category = Category.find(id)
    @insurances = Insurance.where(category_id: id)
  end
end
