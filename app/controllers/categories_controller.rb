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
      flash[:success] = 'Categoria modificata'
      redirect_to dashboard_companies_path
    else
      render "edit"
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:success] = 'Categoria elliminata'
    redirect_to dashboard_categories_path
  end

  def create
    @category = Category.new(category_params)
    @category[:user_id] = current_user[:id]
    if @category.save
      flash[:success] = "Categoria aggiunta"
      redirect_to dashboard_categories_path
    else
      render "new"
    end
  end

  private

  def category_params
    params.require(:category).permit(:category)
  end

end
