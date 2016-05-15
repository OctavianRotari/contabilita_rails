module ActiveInvoiceTotalsHelper
  def total_all_active_invoices
    invoices = Invoice.active
    total = 0
    invoices.each do |invoice|
      total += invoice.total
    end
    total
  end

  def total_vat_all_active_invoices
    invoices = Invoice.active
    total = 0
    invoices.each do |invoice|
      total += invoice.total_vat
    end
    total
  end

  def paid_per_invoice(id)
    invoice = Invoice.find(id)
    total = 0
    invoice.payments.each do |payment|
      total += payment.paid
    end
    total
  end

  def total_collected_all_active_invoices
    invoices = Invoice.active
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    total
  end

  def to_pay_per_invoice(id)
    invoice = Invoice.find(id)
    total = 0
    invoice.payments.each do |payment|
      total += payment.paid
    end
    invoice.total - total
  end

  def total_to_collect_all_active_invoices
    invoices = Invoice.active
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    total_all_passive_invoices - total
  end
end
