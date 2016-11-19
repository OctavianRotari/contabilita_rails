class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_any?

  def new
  end

  def create
    @vehicles = current_user_vehicles
    @ticket = Ticket.new(ticket_params_user_id)
    if @ticket.save
      flash[:success] = 'Multa aggiunta'
      redirect_to tickets_path
    else
      render 'new'
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:total, :date_of_issue, :deadline, :type_of, :vehicle_id)
  end

  def ticket_params_user_id
    ticket_params.merge!(user_id: current_user.id)
  end
end
