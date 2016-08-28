module ListOfCategoriesHelper
  def list_of_categories_selected_value(form)
    if current_request?(controller: 'invoices', action: 'update')
      form.select(:vehicle_id, options_from_collection_for_select(@new_invoice.all_categories_of_company, "id", "category", invoice_new_or_edit..id ))
    else
      form.select(:vehicle_id, options_from_collection_for_select(@new_invoice.all_vehicles, "id", "plate"), prompt: "Mezzi")
    end
  end
end
