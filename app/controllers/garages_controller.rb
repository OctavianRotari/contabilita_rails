class GaragesController < ApplicationController

  def index
    @calculator = Calculator.new
    @garage_invoices = Garage.new
  end

  def passive_invoices
    @invoices = garage_invoices.passive_invoices_grouped
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = garage_invoices.active_invoices_grouped
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  private

  def garage_invoices
    Garage.new
  end
end
