module CheckIfCompanyAndVehicleExists

  def check_if_company_and_vehicle_exists
    if company_exists? && vehicle_exists?
      @new_invoice = NewInvoice.new
    else
      redirect_to root_path
    end
  end

  private

  def company_exists?
    if Company.all.empty?
      flash[:error] = "Aggiungere almeno un'azienda"
      false
    else
      true
    end
  end

  def create_company_or_vehicle
    if params[:commit] == 'Aggiungi azienda'
      create_company
    elsif params[:commit] == 'Aggiungi mezzo'
      create_vehicle
    end
  end

  def vehicle_exists?
    if Vehicle.all.empty?
      flash[:error] = "Aggiungere almeno un mezzo"
      false
    else
      true
    end
  end

end
