module ListOfCompaniesHelper
  def list_of_companies_selected_value(form)
    if !current_page?(new_invoice_path )
      form.select(:company_id, options_from_collection_for_select(@new_invoice.all_companies, "id", "name", @new_invoice.specific_invoice(params).company.id ))
    else
      form.select(:company_id, options_from_collection_for_select(@new_invoice.all_companies, "id", "name"))
    end
  end
end
