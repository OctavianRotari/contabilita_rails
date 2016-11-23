class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_general_expences_any?

  def new
    @vehicles = current_user_vehicles
    @ticket = Ticket.new
  end

  def create
    @vehicles = current_user_vehicles
    @ticket = Ticket.new(ticket_params_user_id)
    if @ticket.save
      type_of = @ticket.type_of
      flash[:success] = 'Multa aggiunta'
      redirect(type_of)
    else
      render 'new'
    end
  end

  def edit
    @vehicles = vehicles
    @ticket = Ticket.find(params[:id])
  end

  def update
    @vehicles = vehicles
    @ticket = Ticket.find(params[:id])
    if @ticket.update(ticket_params_user_id)
      type_of = @ticket.type_of
      flash[:success] = "La multa e' stata aggiornata"
      redirect(type_of)
    else
      render 'edit'
    end
  end

  def destroy
    ticket = Ticket.find(params[:id])
    ticket.destroy
    flash[:success] = 'Multa eliminata'
    redirect_after_destroy(current_user_tickets)
  end

  private

  def redirect(type_of)
    redirect_to vehicle_dashboard_tickets_path(month: time_now.month, year: time_now.year) if type_of == 1
    redirect_to administrative_dashboard_tickets_path(month: time_now.month, year: time_now.year) if type_of == 2
  end

  def time_now
    Time.zone.now
  end

  def ticket_params
    params.require(:ticket).permit(:total, :date_of_issue, :deadline, :type_of, :vehicle_id, :paid, :description)
  end

  def ticket_params_user_id
    ticket_params.merge!(user_id: current_user.id)
  end

  def vehicles
    @_vehicles ||= current_user_vehicles
  end
end
