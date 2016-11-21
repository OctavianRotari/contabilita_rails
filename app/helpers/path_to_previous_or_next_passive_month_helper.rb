module PathToPreviousOrNextPassiveMonthHelper
  def previos_month_menu(type_of_invoice)
    time = Time.new(params[:year], params[:month])
    if url.include? 'companies'
      link_to 'Mese precedente', company(type_of_invoice).call(month: (time -= 1.month).month, year: time.year ), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Mese precedente', vehicle(type_of_invoice).call(month: (time -= 1.month).month, year: time.year ), :remote => true
    elsif url.include? 'general_expenses'
      link_to 'Mese precedente', general_expenses(type_of_invoice).call(month: (time -= 1.month).month, year: time.year ), :remote => true
    elsif url.include? 'categories'
      link_to 'Mese precedente', category(type_of_invoice).call(month: (time -= 1.month).month, year: time.year ), :remote => true
    else
      link_to 'Mese precedente', invoice(type_of_invoice).call(month: (time -= 1.month).month, year: time.year )
    end
  end

  def next_month_menu(type_of_invoice)
    time = Time.new(params[:year], params[:month])
    if url.include? 'companies'
      link_to 'Mese successivo', company(type_of_invoice).call(month: (time += 1.month).month, year: time.year ), :remote => true
    elsif url.include? 'vehicles'
      link_to 'Mese successivo', vehicle(type_of_invoice).call(month: (time += 1.month).month, year: time.year ), :remote => true
    elsif url.include? 'general_expenses'
      link_to 'Mese successivo', general_expenses(type_of_invoice).call(month: (time += 1.month).month, year: time.year ), :remote => true
    elsif url.include? 'categories'
      link_to 'Mese successivo', category(type_of_invoice).call(month: (time += 1.month).month, year: time.year ), :remote => true
    else
      link_to 'Mese successivo', invoice(type_of_invoice).call(month: (time += 1.month).month, year: time.year )
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
