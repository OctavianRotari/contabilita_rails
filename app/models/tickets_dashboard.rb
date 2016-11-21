class TicketsDashboard
  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def administrative
    date = month_params
    administrative_tickets.month(date)
  end

  def vehicle
    date = month_params
    vehicle_tickets.month(date)
  end

  private

  def user_id
    current_user.id
  end

  def administrative_tickets
    current_user_tickets.administrative
  end

  def vehicle_tickets
    current_user_tickets.vehicle
  end

  def current_user_tickets
    current_user.tickets
  end

  def month_params
    month = params[:month]
    year = params[:year]
    Time.new(year, month)
  end
end
