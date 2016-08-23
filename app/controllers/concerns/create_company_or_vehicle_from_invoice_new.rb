module CreateCompanyOrVehicleFromInvoiceNew

  def create_company_or_vehicle
    if params[:commit] == 'Aggiungi azienda'
      create_company
    elsif params[:commit] == 'Aggiungi mezzo'
      create_vehicle
    end
  end

  private

  def create_company
    company = Company.new(company_params)
    if company.save
      redirect_to new_invoice_path
    else
      redirect_to new_invoice_path
      flash[:notice] = 'Azienda non inserita'
    end
  end


  def create_vehicle
    vehicle = Vehicle.new(vehicle_params)
    if vehicle.save
      redirect_to new_invoice_path
    else
      redirect_to new_invoice_path
      flash[:notice] = 'Veicolo non inserita'
    end
  end

end
