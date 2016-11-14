module PreviousOrNextYearFuelReceiptsHelper
  def previos_year_fuel_receipts_company(company)
    link_to 'Anno precedente', fuel_receipts_company_path(company.id, year: params[:year].to_i - 1 )
  end

  def next_year_fuel_receipts_company(company)
    link_to 'Anno successivo', fuel_receipts_company_path(company.id, year: params[:year].to_i + 1)
  end

  def previos_year_fuel_receipts_vehicle(vehicle)
    link_to 'Anno precedente', fuel_receipts_vehicle_path(vehicle.id, year: params[:year].to_i - 1 )
  end

  def next_year_fuel_receipts_vehicle(vehicle)
    link_to 'Anno successivo', fuel_receipts_vehicle_path(vehicle.id, year: params[:year].to_i + 1)
  end
end
