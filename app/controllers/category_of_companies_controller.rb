class CategoryOfCompanyController < ApplicationController

  def new
    @category_of_company = CategoryOfCompany.new
  end

end
