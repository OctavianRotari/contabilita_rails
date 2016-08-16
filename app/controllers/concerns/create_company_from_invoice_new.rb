module CreateCompanyFromInvoiceNew
  def create_company
    if params[:commit] == 'Aggiungi azienda'
      company = Company.new(company_params)
      if company.save
        redirect_to new_invoice_path
      else
        redirect_to new_invoice_path
        flash[:notice] = 'Azienda non inserita'
      end
    end
  end
end
