module PreviousOrNextMonthVehicleCostsHelper
  def previos_month_costs(vehicle)
    time = Time.new(params[:year], params[:month])
    link_to 'Mese precedente', vehicle_path(vehicle.id, month: (time -= 1.month).month, year: time.year )
  end

  def next_month_costs(vehicle)
    time = Time.new(params[:year], params[:month])
    link_to 'Mese successivo', vehicle_path(vehicle.id, month: (time += 1.month).month, year: time.year )
  end
end
