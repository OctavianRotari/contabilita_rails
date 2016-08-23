module ListOfVehiclesHelper
  def list_of_vehicles_selected_value(form)
    if !@new_invoice.all_vehicles.empty?
      if !current_page?(new_invoice_path)
        form.select(:vehicle_id, options_from_collection_for_select(@new_invoice.all_vehicles, "id", "plate", @new_invoice.specific_invoice(params).vehicle.id ))
      else
        form.select(:vehicle_id, options_from_collection_for_select(@new_invoice.all_vehicles, "id", "plate"))
      end
    else
      form.select(:vehicle_id, {}, prompt: "Aggiugi mezzo")
    end
  end
end
