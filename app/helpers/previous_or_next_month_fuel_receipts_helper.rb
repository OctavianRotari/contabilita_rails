module PreviousOrNextMonthFuelReceiptsHelper
  def previos_month_fuel_receipts_company(company)
    time = Time.new(params[:year], params[:month])
    link_to 'Mese precedente', fuel_receipts_company_path(company.id, month: (time -= 1.month).month, year: time.year )
  end

  def next_month_fuel_receipts_company(company)
    time = Time.new(params[:year], params[:month])
    link_to 'Mese successivo', fuel_receipts_company_path(company.id, month: (time += 1.month).month, year: time.year )
  end

  def previos_month_fuel_receipts_vehicle(vehicle)
    time = Time.new(params[:year], params[:month])
    link_to 'Mese precedente', fuel_receipts_vehicle_path(vehicle.id, month: (time -= 1.month).month, year: time.year )
  end

  def next_month_fuel_receipts_vehicle(vehicle)
    time = Time.new(params[:year], params[:month])
    link_to 'Mese successivo', fuel_receipts_vehicle_path(vehicle.id, month: (time += 1.month).month, year: time.year )
  end
end
