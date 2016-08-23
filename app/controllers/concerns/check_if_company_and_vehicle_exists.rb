module CheckIfCompanyAndVehicleExists
  def check_if_company_and_vehicle_exists
    if company_exists? && vehicle_exists?
      @new_invoice = NewInvoice.new
      create_company_or_vehicle
    else
      redirect_to root_path
    end
  end

  private

  def company_exists?
    if Company.all.empty?
      flash[:notice] = "Aggiungere almeno un'azienda"
      false
    else
      true
    end
  end

  def vehicle_exists?
    if Vehicle.all.empty?
      flash[:notice] = "Aggiungere almeno un veicolo"
      false
    else
      true
    end
  end

end
