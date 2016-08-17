module CompanyFormHelper
  def company_instance
    @company || @new_invoice.new_company
  end
end
