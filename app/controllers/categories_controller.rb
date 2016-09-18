class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Categoria modificata'
      redirect_to dashboard_companies_path
    else
      render "edit"
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Categoria aggiunta"
      redirect_to dashboard_companies_path
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:category).permit(:category)
  end

end
