module ListAtTheExpenceOfHelper
  def list_at_the_expence_of_selected_value(form)
    if current_request?(controller: 'invoices', action: 'edit')
      if @new_invoice.specific_invoice(params).at_the_expense_of == 'Veicolo'
        form.select(:vehicle_id, content_tag(:option, 'Officina', value: "garage")+options_from_collection_for_select(@new_invoice.all_vehicles, "id", "plate", invoice_new_or_edit.vehicle.id ))
      else
        form.select(:vehicle_id, content_tag(:option, 'Officina', value: "garage")+options_from_collection_for_select(@new_invoice.all_vehicles, "id", "plate"))
      end
    else
      form.select(:vehicle_id, content_tag(:option, 'Officina', value: "garage")+options_from_collection_for_select(@new_invoice.all_vehicles, "id", "plate"), prompt: "Mezzi")
    end
  end
end
