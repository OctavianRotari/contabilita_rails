module Features
  def company(name)
    Company.create(name:name,adress:'Ravenna',number:'345')
  end

  def create_record(company, method_of_payment='Bonifico')
    company.invoices.create(reason:'Manutenzione', 
                            paid:0, 
                            total:110, 
                            vat:10, 
                            date:'01/04/2015', 
                            plate:'de234ed', 
                            deadline:'30/04/2015', 
                            type_of_payment:method_of_payment)
  end
end
