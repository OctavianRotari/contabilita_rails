module CreateVehicle
  include PathAfterSave

  def create_vehicle
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      flash[:notice] = 'Veicolo inserito'
      path_after_save_success
    else
      flash[:notice] = 'Veicolo non inserito'
      path_after_save_fail
    end
  end

end
