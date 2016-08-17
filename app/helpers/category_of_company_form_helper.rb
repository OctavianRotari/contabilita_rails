module CategoryOfCompanyFormHelper
  def category_of_company_instance
    @category_of_company || @new_invoice.all_categories_of_company
  end
end
