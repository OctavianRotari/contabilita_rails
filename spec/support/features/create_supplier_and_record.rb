module Features
  def supplier(name)
    ClientsAndSupplier.create(name:name,adress:'Ravenna',number:'345')
  end
  def create_record(supplier, method_of_payment='Bonifico')
    supplier.invoices.create(total:100, vat:21, date:'01/04/2015', plate:'de234ed', deadline:'30/04/2015', type_of_payment:method_of_payment)
  end
end
