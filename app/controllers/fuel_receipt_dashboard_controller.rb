class FuelReceiptDashboardController < ApplicationController
  def company_receipts
    @fuel_receipts_dashboard = FuelReceiptDashboard.new(params, current_user)
  end
end
