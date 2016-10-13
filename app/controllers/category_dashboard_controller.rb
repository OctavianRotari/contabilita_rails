class CategoryDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do |record|
    if current_user.categories.empty?
      flash[:error] = "Aggiungere almeno una categoria"
      redirect_to :back
    end
  end

  def index
    @categories = current_user.categories
    @calculator = Calculator.new
  end

  def show
    @calculator = Calculator.new
    @category_dashboard = CategoryDashboard.new(params, current_user)
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
    CategoryDashboard.new(params, current_user)
  end

  def category_params
    params.require(:category).permit(:category)
  end

end
