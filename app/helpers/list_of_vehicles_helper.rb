module ListOfVehiclesHelper
  def list_of_vehicles_selected_value(form)
    if current_request?(controller: 'invoices', action: 'update')
      form.select(:vehicle_id, options_from_collection_for_select(@new_invoice.all_vehicles, "id", "plate", invoice_new_or_edit.vehicle.id ))
    else
      form.select(:vehicle_id, options_from_collection_for_select(@new_invoice.all_vehicles, "id", "plate"))
    end
  end
end
