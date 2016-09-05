module PathAfterSaveCategory
  def path_after_save_success
    if controller_name == "companies"
      company_controller_path
    elsif controller_name == "company_dashboard"
      redirect_to dashboard_companies_path
    end
  end

  def path_after_save_fail
    if controller_name == "companies"
      fails_company_controller_path
    elsif controller_name == "company_dashboard"
      render "company_dashboard/index"
    end
  end


  def company_controller_path
    if action_name == 'new'
      redirect_to dashboard_companies_path
    elsif action_name == 'edit'
      redirect_to edit_company_path(params[:id])
    end
  end


  def fails_company_controller_path
    if action_name == 'new'
      render "new"
    elsif action_name == 'edit'
      render "edit"
    end
  end
end
