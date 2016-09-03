module PathAfterSave

  def path_after_save_success
    if controller_name == "invocies"
      invoice_controller_path
    elsif controller_name == "companies"
      company_controller_path
    elsif controller_name == "vehicles"
      vehicle_controller_path
    end
  end

  def path_after_save_fail
    if controller_name == "invocies"
      fails_invoice_controller_path
    elsif controller_name == "companies"
      fails_company_controller_path
    elsif controller_name == "vehicles"
      fails_vehicle_controller_path
    end
  end

  private

  def invoice_controller_path
    if action_name == 'new'
      redirect_to new_invoice_path
    elsif action_name == 'edit'
      redirect_to edit_invoice_path(params[:id])
    end
  end

  def company_controller_path
    redirect_to dashboard_companies
  end

  def vehicle_controller_path
    redirect_to vehicles_path
  end

  def fails_invoice_controller_path
    if action_name == 'new'
      render "new"
    elsif action_name == 'edit'
      render "edit"
    end
  end

  def fails_company_controller_path
    render "new"
  end

  def fails_vehicle_controller_path
    render "index"
  end

end
