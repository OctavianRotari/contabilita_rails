class TicketsDashboardController < ApplicationController
  def vehicle
    @tickets = tickets_dashboard.vehicle
  end

  def administrative
    @tickets = tickets_dashboard.administrative
  end

  private

  def tickets_dashboard
    TicketsDashboard.new(current_user, params)
  end
end
