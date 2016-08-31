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
    @company = Company.new(company_params)
    if @company.save
      flash[:notice] = 'Azienda inserita'
      redirect_to new_invoice_path
    else
      flash[:notice] = 'Azienda non inserita'
      render "new"
    end
  end


  def create_vehicle
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      flash[:notice] = 'Veicolo inserito'
      redirect_to new_invoice_path
    else
      flash[:notice] = 'Veicolo non inserito'
      render "new"
    end
  end

end
