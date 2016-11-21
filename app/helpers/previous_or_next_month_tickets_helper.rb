module PreviousOrNextMonthTicketsHelper
  def previos_month_administrative_tickets
    time = Time.new(params[:year], params[:month])
    link_to 'Mese precedente', administrative_dashboard_tickets_path(month: (time -= 1.month).month, year: time.year )
  end

  def next_month_administrative_tickets
    time = Time.new(params[:year], params[:month])
    link_to 'Mese successivo', administrative_dashboard_tickets_path(month: (time += 1.month).month, year: time.year )
  end
end
