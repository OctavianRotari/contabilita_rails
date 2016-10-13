class CategoryDashboardController < ApplicationController
  def index
    @categories = Category.all
    @calculator = Calculator.new
  end

  def show
    @calculator = Calculator.new
    @category_dashboard = CategoryDashboard.new(params)
  end


  def passive_invoices
    @invoices = category_dashboard.passive_invoices
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  def active_invoices
    @invoices = category_dashboard.active_invoices
    @calculator = Calculator.new
    respond_to do |format|
      format.js
    end
  end

  private

  def category_dashboard
    CategoryDashboard.new(params)
  end

  def category_params
    params.require(:category).permit(:category)
  end

end
