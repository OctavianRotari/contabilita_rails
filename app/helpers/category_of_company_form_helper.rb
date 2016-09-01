module CategoryOfCompanyFormHelper
  def category_of_company_instance
    @category_of_company || @new_invoice.new_category_of_company
  end
end
