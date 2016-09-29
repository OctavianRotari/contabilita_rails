class Garage < ActiveRecord::Base
  def not_paid_invoices
    passive_invoices = garage_passive_invoices
    passive_invoices.not_paid
  end

  def not_collected_invoices
    active_invoices = garage_active_invoices
    active_invoices.not_collected
  end

  def garage_passive_invoices
    invoices.passive
  end

  def garage_active_invoices
    invoices.active
  end

  def invoices
    Invoice.where(at_the_expense_of: "Officina")
  end
end
