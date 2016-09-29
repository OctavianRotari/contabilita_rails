class GaragesController < ApplicationController

  def show
    @calculator = Calculator.new
    @garage_invoices = Garage.new
  end

end
