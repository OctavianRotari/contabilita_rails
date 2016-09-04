module CreateCategoryOfCompany

  def category_of_company
    @category_of_company = CategoryOfCompany.new(category_params)
    if @category_of_company.save
      flash[:notice] = 'Categoria inserita'
      path_after_save_success
    else
      path_after_save_fail
    end
  end

  private

  def path_after_save_success
    if controller_name == "companies"
      redirect_to new_company_path
    elsif controller_name == "company_dashboard"
      redirect_to dashboard_companies_path
    end
  end

  def path_after_save_fail
    if controller_name == "companies"
      render "new"
    elsif controller_name == "company_dashboard"
      render "company_dashboard/index"
    end
  end

end
