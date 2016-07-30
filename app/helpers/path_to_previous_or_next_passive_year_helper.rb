module PathToPreviousOrNextPassiveYearHelper
  def previos_year_menu(type_of_invoice)
    company_path = company_invoices_dashboard(type_of_invoice)
    vehicle_path = method(("vehicle_#{type_of_invoice}_invoices_path").to_sym)
    invoice_path = method(("#{type_of_invoice}_invoices_path").to_sym)
    if url.include? 'company_invoices_dashboard'
      link_to 'Anno precedente', company_path.call(params[:company_invoices_dashboard_id], year_param: params[:year_param].to_i - 1), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Anno precedente', vehicle_path.call(params[:vehicle_id], year_param: params[:year_param].to_i - 1), :remote => true
    else
      link_to 'Anno precedente', invoice_path.call(year_param: params[:year_param].to_i - 1)
    end
  end

  def next_year_menu(type_of_invoice)
    company_path = company_invoices_dashboard(type_of_invoice)
    vehicle_path = method(("vehicle_#{type_of_invoice}_invoices_path").to_sym)
    invoice_path = method(("#{type_of_invoice}_invoices_path").to_sym)
    if url.include? 'company_invoices_dashboard'
      link_to 'Anno successivo', company_path.call(params[:company_invoices_dashboard_id], year_param: params[:year_param].to_i + 1), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Anno successivo', vehicle_path.call(params[:vehicle_id], year_param: params[:year_param].to_i + 1), :remote => true
    else
      link_to 'Anno successivo', invoice_path.call(year_param: params[:year_param].to_i + 1)
    end
  end

  private

  def company_invoices_dashboard(type_of_invoice)
    method(("company_invoices_dashboard_#{type_of_invoice}_invoices_path").to_sym)
  end

  def url
    request.original_url
  end
end
