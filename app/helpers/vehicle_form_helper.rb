module VehicleFormHelper
  def vehicle_from_view
    @vehicle || @new_invoice.new_vehicle
  end
end
