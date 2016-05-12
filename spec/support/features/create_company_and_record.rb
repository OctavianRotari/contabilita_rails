module Features
  def company(name)
    Company.create(name:name,adress:'Ravenna',number:'345')
  end

  def vehicle(plate="ER341GF")
    Vehicle.create(plate:plate,type_of_vehicle:'trattore')
  end

  def create_active_invoice(parent, reason='Manutenzione')
    parent.invoices.create(reason:reason,
                            total:110,
                            vat:10,
                            vehicle_id: nil,
                            date_of_issue:'01/04/2015',
                            type_of_invoice: 'attiva',
                            taxable:100,
                            deadline:'30/04/2015')
  end


  def create_passive_invoice(parent, reason='Manutenzione',vehicle_id = 1)
    parent.invoices.create(reason:reason,
                            total:110,
                            vat:10,
                            vehicle_id: vehicle_id,
                            date_of_issue:'01/04/2015',
                            type_of_invoice: 'passiva',
                            taxable:100,
                            deadline:'30/04/2015')
  end

  def create_payment(invoice, amount=100)
    invoice.payments.create(paid:amount,method_of_payment:'cassa',payment_date:'01/04/2015')
  end

end
