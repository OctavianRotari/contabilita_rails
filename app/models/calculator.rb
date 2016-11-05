class Calculator
  def total_all(records)
    total = 0
    records.each do |record|
      total += record.total
    end
    total.round(2)
  end

  def total_vat_all(invoices)
    total = 0
    invoices.each do |invoice|
      total += invoice.total_vat
    end
    total.round(2)
  end

  def total_paid_or_collected_all(invoices)
    total = 0
    invoices.each do |invoice|
      total += invoice.total_payments
    end
    total.round(2)
  end

  def total_remaining_all(invoices)
    total_all(invoices) - total_paid_or_collected_all(invoices)
  end

  def to_pay_per(invoice)
    invoice.total - invoice.total_payments.round(2)
  end

  def total_costs_current_month(invoices, fuel_receipts = nil)
    invoices = invoices.current_month_passive_invoices
    if fuel_receipts
      total_all(invoices).round(2) + total_fuel_receipts_current_month(fuel_receipts)
    else
      total_all(invoices).round(2)
    end
  end

  def total_costs_current_year(invoices, fuel_receipts = nil)
    invoices = invoices.current_year_passive_invoices
    if fuel_receipts
      total_all(invoices).round(2) + total_fuel_receipts_current_year(fuel_receipts)
    else
      total_all(invoices).round(2)
    end
  end

  def total_costs_year_garage_divided(invoices)
    (total_costs_current_year(invoices) / number_of_vehicles).round(2)
  end

  def total_costs_month_garage_divided(invoices)
    (total_costs_current_month(invoices) / number_of_vehicles).round(2)
  end

  def total_fuel_receipts_current_month(fuel_receipts)
    fuel_receipts = fuel_receipts.current_month
    total_all(fuel_receipts).round(2)
  end

  def total_fuel_receipts_current_year(fuel_receipts)
    fuel_receipts = fuel_receipts.current_year
    total_all(fuel_receipts).round(2)
  end

  private

  def number_of_vehicles
    Vehicle.count
  end
end
