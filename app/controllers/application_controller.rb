class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    dashboard_invoices_path
  end

  def current_user_companies
    current_user.companies
  end

  def current_user_categories
    current_user.categories
  end

  def current_user_vehicles
    current_user.vehicles
  end

  def current_user_invoices
    current_user.invoices
  end

  def redirect_after_destroy(collection)
    if collection.count > 0
      redirect_to :back
    else
      redirect_to dashboard_invoices_path
    end
  end
end
