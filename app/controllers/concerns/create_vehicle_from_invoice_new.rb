module CreateVehicleFromInvoiceNew
  def create_vehicle
    if params[:commit] == 'Aggiungi mezzo'
      vehicle = Vehicle.new(vehicle_params)
      if vehicle.save
        redirect_to new_invoice_path
      else
        redirect_to new_invoice_path
        flash[:notice] = 'Azienda non inserita'
      end
    end
  end
end
