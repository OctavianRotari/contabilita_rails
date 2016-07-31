class InvoicesDashboard

  def active_ord_by_year(params)
    Invoice.active_invoices.ord_by_year
  end

  def passive_ord_by_year(params)
    Invoice.passive_invoices.ord_by_year
  end

  private

  def passive_invoices
    where(type_of_invoice: 'passiva')
  end

  def active_invoices
    where(type_of_invoice: 'attiva')
  end

  def ord_by_year
    where("cast(strftime('%Y', date_of_issue) as int) = ?", params[:year_param] )
  end

end
