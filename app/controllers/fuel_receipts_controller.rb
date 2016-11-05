class FuelReceiptsController < ApplicationController
  before_action :authenticate_user!
  before_action :gas_station_category_any?
  before_action :gas_station_company_any?

  def index
    @fuel_receipt_dashboard = fuel_receipt_dashboard
  end

  def new
    @fuel_receipt = FuelReceipt.new
    @companies = fuel_receipt_dashboard.gas_station_companies
    @vehicles = current_user.vehicles
  end

  def edit
    @fuel_receipt = FuelReceipt.find(params[:id])
    @companies = fuel_receipt_dashboard.gas_station_companies
    @vehicles = current_user.vehicles
  end

  def update
    @fuel_receipt = FuelReceipt.find(params[:id])
    @companies = fuel_receipt_dashboard.gas_station_companies
    @vehicles = current_user.vehicles
    if @fuel_receipt.update(fuel_receipt_params)
      flash[:success] = 'Scontrino aggiunto'
      redirect_to fuel_receipts_path
    else
      render 'edit'
    end
  end

  def destroy
    fuel_receipt = FuelReceipt.find(params[:id])
    fuel_receipt.destroy
    flash[:success] = 'Scontrino elliminata'
    redirect_after_destroy(current_user_fuel_receipts)
  end

  def create
    @companies = fuel_receipt_dashboard.gas_station_companies
    @vehicles = current_user.vehicles
    @fuel_receipt = FuelReceipt.new(fuel_receipt_params_user_id)
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
                                         :litres,
                                         :company_id,
                                         :vehicle_id,
                                         :date_of_issue)
  end

  def fuel_receipt_dashboard
    FuelReceiptDashboard.new(params[:id], current_user)
  end

  def fuel_receipt_params_user_id
    fuel_receipt_params.merge!(user_id: current_user[:id])
  end
end
