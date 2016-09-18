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

  def passive_amount_to_pay(companies)
    total_passive = 0
    companies.each do |company|
      invoices = company.invoices
      total_passive += total_remaining_all(invoices.passive)
    end
    total_passive
  end

  def active_amount_to_collect(companies)
    total_active = 0
    companies.each do |company|
      invoices = company.invoices
      total_active += total_remaining_all(invoices.active)
    end
    total_active
  end

  #should belong to another class
  def total_costs_current_month(category_id)
    invoices = Invoice.where( category_id: category_id ).current_month_passive_invoices
    total_all(invoices)
  end

  def total_costs_current_year(category_id)
    invoices = Invoice.where( category_id: category_id ).current_year_passive_invoices
    total_all(invoices)
  end

  def total_costs_current_month_vehicle(vehicle_id)
    invoices = Invoice.where( vehicle_id: vehicle_id ).current_month_passive_invoices
    total_all(invoices)
  end

  def total_costs_current_year_vehicle(vehicle_id)
    invoices = Invoice.where( vehicle_id: vehicle_id ).current_year_passive_invoices
    total_all(invoices)
  end

  private

  def category(category_id)
    Category.find(category_id)
  end

  def vehicle(vehicle_id)
    Vehicle.find(vehicle_id)
  end

end
