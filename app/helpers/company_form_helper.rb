module CompanyFormHelper
  def company_from_view
    @company || @new_invoice.new_company
  end
end
