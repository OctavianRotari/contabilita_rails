module InvoiceTotalsHelper
  def total_all_invoices
    invoices = Invoice.all
    total = 0
    invoices.each do |invoice|
      total += invoice.total
    end
    total
  end

  def total_vat_all_invoices
    invoices = Invoice.all
    total = 0
    invoices.each do |invoice|
      total += invoice.vat
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

  def total_paid_all_invoices
    invoices = Invoice.all
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

  def total_to_pay_all_invoices
    invoices = Invoice.all
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    total_all_invoices - total
  end
end
