module PathToPreviousOrNextPassiveYearHelper
  def previos_year_menu(type_of_invoice)
    if url.include? 'company_dashboard'
      link_to 'Anno precedente', company_dashboard(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i - 1), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Anno precedente', vehicle_invoices(type_of_invoice).call(params[:vehicle_id], year_param: params[:year_param].to_i - 1), :remote => true
    else
      link_to 'Anno precedente', invoices(type_of_invoice).call(year_param: params[:year_param].to_i - 1)
    end
  end

  def next_year_menu(type_of_invoice)
    if url.include? 'company_dashboard'
      link_to 'Anno successivo', company_dashboard(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i + 1), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Anno successivo', vehicle_invoices(type_of_invoice).call(params[:vehicle_id], year_param: params[:year_param].to_i + 1), :remote => true
    else
      link_to 'Anno successivo', invoices(type_of_invoice).call(year_param: params[:year_param].to_i + 1)
    end
  end

  private

  def company_dashboard(type_of_invoice)
    method(("#{type_of_invoice}_invoices_company_dashboard_path").to_sym)
  end

  def vehicle_invoices(type_of_invoice)
    method(("vehicle_#{type_of_invoice}_invoices_path").to_sym)
  end

  def invoices(type_of_invoice)
    method(("#{type_of_invoice}_invoices_dashboard_index_path").to_sym)
  end

  def url
    request.original_url
  end
end
