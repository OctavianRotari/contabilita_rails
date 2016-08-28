module CategoryOfCompanyHelper
  def category_of_company(category_id)
    CategoryOfCompany.find(category_id).category
  end
end
