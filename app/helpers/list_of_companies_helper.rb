module ListOfCompaniesHelper
  def list_of_companies_selected_value(form)
    if current_request?(controller: 'invoices', action: 'update')
      form.select(:company_id, options_from_collection_for_select(@companies, "id", "name", @invoice.company.id ))
    else
      form.select(:company_id, options_from_collection_for_select(@companies, "id", "name"), prompt: "Aziende")
    end
  end
end
