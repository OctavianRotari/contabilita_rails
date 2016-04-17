module Features
  def company(name)
    Company.create(name:name,adress:'Ravenna',number:'345')
  end

  def create_invoice(company, reason='Manutenzione')
    company.invoices.create(reason:reason,
                            total:110,
                            vat:10,
                            date:'01/04/2015',
                            plate:'de234ed',
                            taxable:100,
                            deadline:'30/04/2015')
  end

  def create_payment(invoice, amount=100)
    invoice.payments.create(paid:amount,method_of_payment:'cassa',date:'01/04/2015')
  end

end
