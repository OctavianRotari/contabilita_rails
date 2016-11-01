module Features
  def create_active_invoice(parent, reason = 'Manutenzione', vehicle_id = 1)
    parent.invoices.create(reason: reason,
                           total: 110,
                           total_vat: 10,
                           user_id: 1,
                           vehicle_id: vehicle_id,
                           at_the_expense_of: 'Veicolo',
                           category_id: 1,
                           date_of_issue: Time.now,
                           type_of_invoice: 'attiva',
                           total_taxable: 100,
                           deadline: Time.now)
  end


  def create_passive_invoice(parent, reason = 'Manutenzione', vehicle_id = 1)
    parent.invoices.create(reason: reason,
                           total: 110,
                           total_vat: 10,
                           category_id: 1,
                           user_id: 1,
                           vehicle_id: vehicle_id,
                           at_the_expense_of: 'Veicolo',
                           date_of_issue: Time.now,
                           type_of_invoice: 'passiva',
                           total_taxable: 100,
                           deadline: Time.now)
  end

  def create_passive_invoice_different_date(parent, date, reason = 'Manutenzione', vehicle_id = 1)
    parent.invoices.create(reason: reason,
                           total: 110,
                           total_vat: 10,
                           category_id: 1,
                           user_id: 1,
                           vehicle_id: vehicle_id,
                           at_the_expense_of: 'Veicolo',
                           date_of_issue: date,
                           type_of_invoice: 'passiva',
                           total_taxable: 100,
                           deadline: Time.now)
  end

  def create_payment(invoice, amount = 100)
    invoice.payments.create(paid: amount,
                            method_of_payment: 'cassa',
                            payment_date: '01/04/2015')
  end
end
