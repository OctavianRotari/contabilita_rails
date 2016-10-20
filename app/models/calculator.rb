class Calculator < ActiveRecord::Base

  def total_all(invoices)
    total = 0
    invoices.each do |invoice|
      total += invoice.total
    end
    total
  end

  def total_vat_all(invoices)
    total = 0
    invoices.each do |invoice|
      total += invoice.total_vat
    end
    total
  end

  def total_paid_or_collected_all(invoices)
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    total
  end

  def total_remaining_all(invoices)
    total_all(invoices) - total_paid_or_collected_all(invoices)
  end

  def paid_per(invoice)
    total = 0
    invoice.payments.each do |payment|
      total += payment.paid
    end
    total
  end

  def to_pay_per(invoice)
    invoice.total - paid_per(invoice)
  end

  def total_costs_current_month(invoices)
    invoices = invoices.current_month_passive_invoices
    total_all(invoices).round(2)
  end

  def total_costs_current_year(invoices)
    invoices = invoices.current_year_passive_invoices
    total_all(invoices).round(2)
  end

  def total_costs_year_garage_divided(invoices)
    (total_costs_current_year(invoices) / number_of_vehicles).round(2)
  end

  def total_costs_month_garage_divided(invoices)
    (total_costs_current_month(invoices) / number_of_vehicles).round(2)
  end

  private

  def number_of_vehicles
    Vehicle.count
  end

end
