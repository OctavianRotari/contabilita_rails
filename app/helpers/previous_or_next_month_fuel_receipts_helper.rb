module PreviousOrNextMonthFuelReceiptsHelper
  def previos_month_fuel_receipts(company)
    link_to 'Mese precedente', fuel_receipts_company_path(company.id, month: params[:month].to_i )
  end

  def next_month_fuel_receipts(company)
    link_to 'Mese successivo', fuel_receipts_company_path(company.id, month: params[:month].to_i + 1)
  end
end
