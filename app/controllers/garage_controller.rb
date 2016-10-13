class GarageController < ApplicationController
  before_action :authenticate_user!
  before_action do |record|
    if Vehicle.all.empty?
      flash[:error] = "Aggiungere almeno un mezzo"
      redirect_to :back
    end
  end

  def index
    @calculator = Calculator.new
    @garage_invoices = Garage.new(params, current_user)
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
    Garage.new(params, current_user)
  end
end
