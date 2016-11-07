module ListAtTheExpenceOfHelper
  def list_at_the_expence_of_selected_value(form)
    if current_request?(controller: 'invoices', action: 'edit')
      if @invoice.at_the_expense_of == 'Veicolo'
        form.select(:vehicle_id, content_tag(:option, 'Spese generali', value: "general_expences")+options_from_collection_for_select(@vehicles, "id", "plate", @invoice.vehicle.id ))
      else
        form.select(:vehicle_id, content_tag(:option, 'Spese generali', value: "general_expences")+options_from_collection_for_select(@vehicles, "id", "plate"))
      end
    else
      form.select(:vehicle_id, content_tag(:option, 'Spese generali', value: "general_expences")+options_from_collection_for_select(@vehicles, "id", "plate"), prompt: "Mezzi")
    end
  end
end
