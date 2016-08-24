module ListOfCompaniesHelper
  def list_of_companies_selected_value(form)
    if current_request?(controller: 'invoices', action: 'update')
      form.select(:company_id, options_from_collection_for_select(@new_invoice.all_companies, "id", "name", invoice_new_or_edit.company.id ))
    else
      form.select(:company_id, options_from_collection_for_select(@new_invoice.all_companies, "id", "name"))
    end
  end
end
