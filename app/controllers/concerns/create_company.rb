module CreateCompany
  include PathAfterSave

  def create_company
    @company = Company.new(company_params)
    if @company.save
      flash[:notice] = 'Azienda inserita'
      path_after_save_success
    else
      flash[:notice] = 'Azienda non inserita'
      path_after_save_fail
    end
  end

end
