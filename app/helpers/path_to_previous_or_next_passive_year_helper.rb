module PathToPreviousOrNextPassiveYearHelper
  def previos_year_menu(type_of_invoice)
    url = request.original_url
    company_path = method(("company_#{type_of_invoice}_invoices_path").to_sym)
    vehicle_path = method(("vehicle_#{type_of_invoice}_invoices_path").to_sym)
    invoice_path = method(("#{type_of_invoice}_invoices_path").to_sym)
    if url.include? 'companies'
      link_to 'Anno precedente', company_path.call(params[:company_id], year_param: params[:year_param].to_i - 1), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Anno precedente', vehicle_path.call(params[:vehicle_id], year_param: params[:year_param].to_i - 1), :remote => true
    else
      link_to 'Anno precedente', invoice_path.call(year_param: params[:year_param].to_i - 1)
    end
  end

  def next_year_menu(type_of_invoice)
    url = request.original_url
    company_path = method(("company_#{type_of_invoice}_invoices_path").to_sym)
    vehicle_path = method(("vehicle_#{type_of_invoice}_invoices_path").to_sym)
    invoice_path = method(("#{type_of_invoice}_invoices_path").to_sym)
    if url.include? 'companies'
      link_to 'Anno successivo', company_path.call(params[:company_id], year_param: params[:year_param].to_i + 1), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Anno successivo', vehicle_path.call(params[:vehicle_id], year_param: params[:year_param].to_i + 1), :remote => true
    else
      link_to 'Anno successivo', invoice_path.call(year_param: params[:year_param].to_i + 1)
    end
  end
end
