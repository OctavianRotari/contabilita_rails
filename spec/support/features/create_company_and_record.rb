module Features
  def company(name)
    Company.create(name:name,adress:'Ravenna',number:'345')
  end

  def vehicle(plate)
    Vehicle.create(plate:plate,type_of_vehicle:'trattore')
  end

  def create_invoice(parent, reason='Manutenzione',vehicle_id = 1)
    parent.invoices.create(reason:reason,
                            total:110,
                            vat:10,
                            vehicle_id: vehicle_id,
                            date_of_issue:'01/04/2015',
                            taxable:100,
                            deadline:'30/04/2015')
  end

  def create_payment(invoice, amount=100)
    invoice.payments.create(paid:amount,method_of_payment:'cassa',payment_date:'01/04/2015')
  end

end
