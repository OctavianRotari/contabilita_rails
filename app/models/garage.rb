class Garage < ActiveRecord::Base
  def not_paid_invoices
    passive_invoices.not_paid
  end

  def not_collected_invoices
    active_invoices.not_collected
  end

  def passive_invoices
    invoices.passive
  end

  def active_invoices
    invoices.active
  end

  def active_invoices_grouped
    active_invoices.group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def passive_invoices_grouped
    passive_invoices.group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def invoices
    Invoice.where(at_the_expense_of: "Officina")
  end
end
