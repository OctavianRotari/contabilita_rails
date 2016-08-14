class InvoiceDashboard

  def active_ord_by_year(params)
    Invoice.all.active_ord_by_year(params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def passive_ord_by_year(params)
    Invoice.all.passive_ord_by_year(params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

end
