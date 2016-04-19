module Unit
  def company(name)
    Company.create(name:name,adress:'Ravenna',number:'345')
  end

  def create_vehicle(plate="ER354BS")
    Vehicle.create(plate:plate,type_of_vehicle:'trattore')
  end

  def create_record(company, method_of_payment='Bonifico')
    company.invoices.create(total:100, vat:10, date_of_issue:'01/04/2015', deadline:'30/04/2015')
  end
end
