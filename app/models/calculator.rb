class Calculator
  def total_paid_or_collected_all(invoices)
    total = 0
    invoices.each do |invoice|
      total += invoice.total_payments
    end
    total.round(2)
  end

  def total_remaining_all(invoices)
    invoices.total_all - total_paid_or_collected_all(invoices)
  end

  def total_general_expenses_month(invoices, current_user)
    total_costs_month = invoices.month_passive.total_all
    (total_costs_month / number_of_vehicles(current_user)).round(2)
  end

  def total_general_expenses_year(invoices, current_user)
    total_costs_year = invoices.year_passive.total_all
    (total_costs_year / number_of_vehicles(current_user)).round(2)
  end

  private

  def number_of_vehicles(current_user)
    Vehicle.count_vehicles_general(current_user.id)
  end
end
