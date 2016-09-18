module ListOfCategoriesHelper
  def list_of_categories_selected_value(form)
    if current_request?(controller: 'companies', action: 'edit')
      form.select(:category_id, options_from_collection_for_select(@category, "id", "category", @company.category.id ))
    else
      form.select(:category_id, options_from_collection_for_select(@category, "id", "category"), prompt: "Categorie")
    end
  end
end
