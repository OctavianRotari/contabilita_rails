module TotalsInvoicesHelper

  def total_all_invoices(invoices)
    total = 0
    invoices.each do |invoice|
      total += invoice.total
    end
    total
  end

  def total_vat_all_invoices(invoices)
    total = 0
    invoices.each do |invoice|
      total += invoice.total_vat
    end
    total
  end

  def paid_per_invoice(id)
    total = 0
    invoice(id).payments.each do |payment|
      total += payment.paid
    end
    total
  end

  def to_pay_per_invoice(id)
    total = 0
    invoice(id).payments.each do |payment|
      total += payment.paid
    end
    invoice(id).total - total
  end

  def total_paid_or_collected_all_invoices(invoices)
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    total
  end

  def total_remaining_all_invoices(invoices)
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    total_all_invoices(invoices) - total
  end

  private

  def invoice(id)
    Invoice.find(id)
  end

end
