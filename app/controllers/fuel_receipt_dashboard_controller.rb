class FuelReceiptDashboardController < ApplicationController
  def company_receipts
    @fuel_receipts_dashboard = FuelReceiptDashboard.new(params, current_user)
    @fuel_receipts_calculator = FuelReceiptCalculator.new
  end

  def vehicle_receipts
    @fuel_receipts_dashboard = FuelReceiptDashboard.new(params, current_user)
    @fuel_receipts_calculator = FuelReceiptCalculator.new
  end
end
