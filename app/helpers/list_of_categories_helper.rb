module ListOfCategoriesHelper
  def list_of_categories_selected_value(form)
    if current_request?(controller: 'companies', action: 'edit')
      form.select(:category_of_company_id, options_from_collection_for_select(@category_of_companies, "id", "category", @company.category_of_company.id ))
    else
      form.select(:category_of_company_id, options_from_collection_for_select(@category_of_companies, "id", "category"), prompt: "Mezzi")
    end
  end
end
