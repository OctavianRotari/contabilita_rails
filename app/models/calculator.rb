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
    total = 0
    invoices.each do |invoice|
      invoice.payments.each do |payment|
        total += payment.paid
      end
    end
    total_all(invoices) - total
  end

  def paid_per(invoice)
    total = 0
    invoice.payments.each do |payment|
      total += payment.paid
    end
    total
  end

  def to_pay_per(invoice)
    total = 0
    invoice.payments.each do |payment|
      total += payment.paid
    end
    invoice.total - total
  end

end
