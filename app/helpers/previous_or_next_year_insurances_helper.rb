module PreviousOrNextYearInsurancesHelper
  def previos_year_insurances(company)
    link_to 'anno precedente', insurances_company_path(company.id, year: params[:year].to_i - 1 )
  end

  def next_year_insurances(company)
    link_to 'anno successivo', insurances_company_path(company.id, year: params[:year].to_i + 1)
  end

  def previos_year_category_insurances(category)
    link_to 'anno precedente', insurances_category_path(category.id, year: params[:year].to_i - 1 )
  end

  def next_year_category_insurances(category)
    link_to 'anno successivo', insurances_category_path(category.id, year: params[:year].to_i + 1)
  end
end
