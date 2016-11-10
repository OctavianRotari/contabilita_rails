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

  def current_user_vehicles_general_expences
    current_user.vehicles.charge_general_expences
  end

  def current_user_invoices
    current_user.invoices
  end

  def current_user_fuel_receipts
    current_user.fuel_receipts
  end

  def vehicle_any?
    if current_user_vehicles.empty?
      flash[:error] = 'Aggiungere almeno un mezzo'
      redirect_to :back
    end
  end

  def vehicle_general_expences_any?
    if current_user_vehicles_general_expences.empty?
      flash[:error] = "Aggiungere prima un mezzo che e' imputabile per le spese generali"
      redirect_to :back
    end
  end

  def category_any?
    if current_user.categories.empty?
      flash[:error] = 'Aggiungere almeno una categoria'
      redirect_to :back
    end
  end

  def gas_station_category_any?
    unless current_user_categories.gas_station
      flash[:error] = 'Aggiungere una categoria che indichi i benzinaii'
      redirect_to :back
    end
  end

  def insurance_category_any?
    unless current_user_categories.insurance
      flash[:error] = 'Aggiungere una categoria che indichi le assicurazioni'
      redirect_to :back
    end
  end

  def company_any?
    if current_user_companies.empty?
      flash[:error] = "Aggiungere almeno un'azienda"
      redirect_to :back
    end
  end

  def gas_station_company_any?
    if current_user_companies.gas_stations.empty?
      flash[:error] = "Aggiungere almeno un'azienda di benzinaii"
      redirect_to :back
    end
  end

  def insurance_company_any?
    if current_user_companies.insurances.empty?
      flash[:error] = "Aggiungere almeno una compania assicurativa"
      redirect_to :back
    end
  end

  def redirect_after_destroy(collection)
    if collection.count > 0
      redirect_to :back
    else
      redirect_to dashboard_invoices_path
    end
  end
end
