class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def passive_invoices
    @invoices = Vehicle.find(params[:vehicle_id]).invoices.passive_ord_by_year(params)
    @invoices_month = @invoices.group_by { |t| t.date_of_issue.beginning_of_month }
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = Vehicle.find(params[:vehicle_id]).invoices.active_ord_by_year(params)
    @invoices_month = @invoices.group_by { |t| t.date_of_issue.beginning_of_month }
    respond_to do |format|
      format.js
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    vehicle = Vehicle.find(params[:id])
    vehicle.update(vehicle_params)
    redirect_to vehicles_path
  end

  def destroy
    vehicle = Vehicle.find(params[:id])
    vehicle.destroy
    flash[:notice] = 'Mezzo elliminato'
    redirect_to vehicles_path
  end

  def create
    vehicle = Vehicle.new(vehicle_params)
    if vehicle.save
      redirect_to vehicles_path
    else
      redirect_to vehicle_new_path
    end
  end

  private
  def vehicle_params
    params.require(:vehicle).permit(:plate, :type_of_vehicle)
  end
end
