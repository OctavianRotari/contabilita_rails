module Unit
  def company(name)
    Company.create(name:name,adress:'Ravenna',number:'345')
  end

  def create_vehicle(plate="ER354BS")
    Vehicle.create(plate:plate,type_of_vehicle:'trattore')
  end

  def create_record(company)
    company.invoices.create(total:110, vat:10, taxable:100, reason:'Manutenzione', vehicle_id:1, date_of_issue:'01/04/2015', deadline:'30/04/2015')
  end

  def add_payment_to_invoice(invoice)
    invoice.payments.create(paid:60, method_of_payment:'cassa',payment_date:'01/04/2015')
  end
end
