module CreateCategoryOfCompany
  include PathAfterSaveCategory

  def category_of_company
    @category_of_company = CategoryOfCompany.new(category_params)
    if @category_of_company.save
      flash[:notice] = 'Categoria inserita'
      path_after_save_success
    else
      flash[:notice] = 'Categoria non inserita'
      path_after_save_fail
    end
  end
end
