module PreviousOrNextYearTicketsHelper
  def previos_month_administrative_tickets
    time_now = Time.zone.now
    time = Time.new(time_now.year, params[:month])
    link_to 'Mese precedente', administrative_dashboard_tickets_path(month: (time - 1.month).month, year: time_now.year )
  end

  def next_month_administrative_tickets
    time_now = Time.zone.now
    time = Time.new(time_now.year, params[:month])
    link_to 'Mese successivo', administrative_dashboard_tickets_path(month: (time + 1.month).month, year: time_now.year )
  end
end
