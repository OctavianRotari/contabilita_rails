module ListOfVehiclesHelper
  def list_of_vehicles(form)
    if current_request?(controller: 'fuel_receipts', action: 'edit')
      form.select(:vehicle_id, options_from_collection_for_select(@vehicles, "id", "plate", @fuel_receipt.vehicle.id ))
    else
      form.select(:vehicle_id, options_from_collection_for_select(@vehicles, "id", "plate"), prompt: "Mezzi")
    end
  end
end
