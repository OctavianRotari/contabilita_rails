module CategoryOfCompanyFormHelper
  def category_of_company_from_view
    @category_of_comapny || @new_invoice.all_categories_of_company
  end
end
