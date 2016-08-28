module CheckIfCategoryOfCompanyExists
  def category_of_company_exists?
    if CategoryOfCompany.all.empty?
      flash[:notice] = "Aggiungere almeno una categoria di aziende"
      false
    else
      true
    end
  end
end
