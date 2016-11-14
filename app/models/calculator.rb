class Calculator
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

  def total_general_expenses_month(invoices)
    total_costs_month = invoices.month_passive.total_all
    (total_costs_month / number_of_vehicles).round(2)
  end

  def total_general_expenses_year(invoices)
    total_costs_year = invoices.year_passive.total_all
    (total_costs_year / number_of_vehicles).round(2)
  end

  def total_fuel_receipts_current_month(fuel_receipts)
    fuel_receipts = fuel_receipts.current_month
    return 0 if fuel_receipt.empty?
    total_all(fuel_receipts).round(2)
  end

  def total_fuel_receipts_current_year(fuel_receipts)
    fuel_receipts = fuel_receipts.current_year
    return 0 if fuel_receipt.empty?
    total_all(fuel_receipts).round(2)
  end

  def total_insurance_costs_current_month(insurances)
    insurances = insurances.current_year
    return 0 if insurances.empty?
    (total_all(insurances) / 12).round(2)
  end

  def total_insurance_costs_current_year(insurances)
    insurances = insurances.current_year
    return 0 if insurances.empty?
    total_all(insurances)
  end

  def total_costs_vehicle_current_month(vehicle_id)
    vehicle = vehicle(vehicle_id)
    invoices = vehicle.invoices.current_month_passive_invoices
    fuel_receipts = vehicle.fuel_receipts.current_month
    insurance = insurance(vehicle)
    month_general_expenses = total_general_expenses_month(invoices)
    (month_general_expenses + total_all(invoices) + total_all(fuel_receipts) + insurance / 12).round(2)
  end

  def total_costs_vehicle_current_year(vehicle_id)
    vehicle = vehicle(vehicle_id)
    invoices = vehicle.invoices.current_year_passive_invoices
    fuel_receipts = vehicle.fuel_receipts.current_year
    insurance = insurance(vehicle)
    year_general_expeses = total_general_expenses_year(invoices)
    (total_all(invoices) + total_all(fuel_receipts) + insurance + year_general_expeses).round(2)
  end

  private

  def insurance(vehicle)
    insurance = vehicle.insurance
    return 0 unless insurance
    insurance.total
  end

  def number_of_vehicles
    Vehicle.general_expences_count
  end

  def vehicle(id)
    Vehicle.find(id)
  end
end
