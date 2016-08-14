class InvoiceDashboard

  def active(params)
    active_invoices(params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def passive(params)
    passive_invoices(params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  private

  def all_invoices
    Invoice.all
  end

  def active_invoices(params)
    all_invoices.active_ord_by_year(params)
  end

  def passive_invoices(params)
    all_invoices.passive_ord_by_year(params)
  end

end
