module PreviousOrNextYearInsurancesHelper
  def previos_year_insurances(company)
    link_to 'Anno precedente', insurances_company_path(company.id, year: params[:year].to_i - 1 )
  end

  def next_year_insurances(company)
    link_to 'Anno successivo', insurances_company_path(company.id, year: params[:year].to_i + 1)
  end
end
