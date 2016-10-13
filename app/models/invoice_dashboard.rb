class InvoiceDashboard

  def initialize(current_user)
    @current_user = current_user
  end

  def active(params)
    active_invoices(params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def passive(params)
    passive_invoices(params).group_by { |t| t.date_of_issue.beginning_of_month }
  end

  def not_paid_invoices
    not_paid_invoices = []
    passive_invoices = all_invoices.passive
    passive_invoices.each do |invoice|
      total_paid = 0
      invoice.payments.each do |payment|
        total_paid = payment.paid
      end
      if invoice.total != total_paid
        not_paid_invoices.push(invoice)
      end
    end
    not_paid_invoices
  end

  def not_collected_invoices
    not_collected_invoices = []
    active_invoices = all_invoices.active
    active_invoices.each do |invoice|
      total_paid = 0
      invoice.payments.each do |payment|
        total_paid = payment.paid
      end
      if invoice.total != total_paid
        not_collected_invoices.push(invoice)
      end
    end
    not_collected_invoices
  end

  private

  def all_invoices
    @current_user.invoices
  end

  def active_invoices(params)
    all_invoices.active_ord_by_year(params)
  end

  def passive_invoices(params)
    all_invoices.passive_ord_by_year(params)
  end

end
