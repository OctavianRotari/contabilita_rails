module PathToPreviousOrNextPassiveYearHelper
  def previos_year_menu(type_of_invoice)
    if url.include? 'companies'
      link_to 'Anno precedente', company(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i - 1), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Anno precedente', vehicle(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i - 1), :remote => true
    elsif url.include? 'general_expenses'
      link_to 'Anno precedente', general_expenses(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i - 1), :remote => true
    elsif url.include? 'categories'
      link_to 'Anno precedente', category(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i - 1), :remote => true
    else
      link_to 'Anno precedente', invoice(type_of_invoice).call(year_param: params[:year_param].to_i - 1)
    end
  end

  def next_year_menu(type_of_invoice)
    if url.include? 'companies'
      link_to 'Anno successivo', company(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i + 1), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Anno successivo', vehicle(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i + 1), :remote => true
    elsif url.include? 'general_expenses'
      link_to 'Anno successivo', general_expenses(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i + 1), :remote => true
    elsif url.include? 'categories'
      link_to 'Anno successivo', category(type_of_invoice).call(params[:id], year_param: params[:year_param].to_i + 1), :remote => true
    else
      link_to 'Anno successivo', invoice(type_of_invoice).call(year_param: params[:year_param].to_i + 1)
    end
  end

  private

  def company(type_of_invoice)
    method(("#{type_of_invoice}_invoices_company_path").to_sym)
  end

  def vehicle(type_of_invoice)
    method(("#{type_of_invoice}_invoices_vehicle_path").to_sym)
  end

  def general_expenses(type_of_invoice)
    method(("#{type_of_invoice}_invoices_general_expenses_path").to_sym)
  end

  def category(type_of_invoice)
    method(("#{type_of_invoice}_invoices_category_path").to_sym)
  end

  def invoice(type_of_invoice)
    method(("#{type_of_invoice}_invoices_path").to_sym)
  end

  def url
    request.original_url
  end
end
