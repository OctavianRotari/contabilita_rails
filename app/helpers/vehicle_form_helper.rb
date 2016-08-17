module VehicleFormHelper
  def vehicle_instance
    @vehicle || @new_invoice.new_vehicle
  end
end
