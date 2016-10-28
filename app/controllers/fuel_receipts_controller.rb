class FuelReceiptsController < ApplicationController
  before_action :authenticate_user!
  before_action do |record|
    if current_user.categories.gas_station_id == nil
      flash[:error] = "Aggiungere una categoria che indichi i benzinaii e almeno una compagnia registrata su tale categoria"
      redirect_to :back
    end
  end

  def index
    @gas_station_companies = current_user_companies.gas_stations
  end

  def new
    @fuel_receipt = FuelReceipt.new
    @companies = current_user_companies.gas_stations
    @vehicles = current_user.vehicles
  end

  def create
    @companies = current_user_companies.gas_stations
    @vehicles = current_user.vehicles
    @fuel_receipt = FuelReceipt.new(fuel_receipt_params)
    @fuel_receipt[:user_id] = current_user[:id]
    if @fuel_receipt.save
      flash[:success] = 'Scontrino aggiunto'
      redirect_to fuel_receipts_path
    else
      render 'new'
    end
  end

  private

  def fuel_receipt_params
    params.require(:fuel_receipt).permit(:total,
                                         :company_id,
                                         :vehicle_id,
                                         :date_of_issue)
  end

  def current_user_companies
    current_user.companies
  end
end
