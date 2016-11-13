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

  def total_costs_current_month(invoices)
    invoices = invoices.current_month_passive_invoices
    total_all(invoices).round(2)
  end

  def total_costs_current_year(invoices)
    invoices = invoices.current_year_passive_invoices
    total_all(invoices).round(2)
  end

  def total_general_expenses_month(invoices)
    (total_costs_current_month(invoices) / number_of_vehicles).round(2)
  end

  def total_general_expenses_year(invoices)
    (total_costs_current_year(invoices) / number_of_vehicles).round(2)
  end

  def total_fuel_receipts_current_month(fuel_receipts)
    fuel_receipts = fuel_receipts.current_month
    total_all(fuel_receipts).round(2)
  end

  def total_fuel_receipts_current_year(fuel_receipts)
    fuel_receipts = fuel_receipts.current_year
    total_all(fuel_receipts).round(2)
  end

  def total_insurance_costs_current_month(insurances)
    insurances = insurances.current_year
    (total_all(insurances) / 12).round(2)
  end

  def total_insurance_costs_current_year(insurances)
    insurances = insurances.current_year
    total_all(insurances)
  end

  def total_costs_vehicle_current_month(vehicle_id)
    vehicle = vehicle(vehicle_id)
    invoices = vehicle.invoices.current_month_passive_invoices
    fuel_receipts = vehicle.fuel_receipts.current_month
    insurance = insurance(vehicle)
    (total_all(invoices) + total_all(fuel_receipts) + insurance / 12).round(2)
  end

  def total_costs_vehicle_current_year(vehicle_id)
    vehicle = vehicle(vehicle_id)
    invoices = vehicle.invoices.current_year_passive_invoices
    fuel_receipts = vehicle.fuel_receipts.current_year
    insurance = insurance(vehicle)
    (total_all(invoices) + total_all(fuel_receipts) + insurance).round(2)
  end

  private

  def insurance(vehicle)
    insurance = vehicle.insurance
    return 0 unless insurance
    insurance.total
  end

  def number_of_vehicles
    Vehicle.charge_general_expences.count
  end

  def vehicle(id)
    Vehicle.find(id)
  end
end
