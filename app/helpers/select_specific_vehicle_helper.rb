module SelectSpecificVehicleHelper
  def select_specific_vehicle(invoice, form)
    if invoice.vehicle_id
      render 'vehicles/specific_vehicles', form: form
    end
  end
end
