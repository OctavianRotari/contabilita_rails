FactoryGirl.define do
  factory :user do
    email('octavianrotari@example.com')
    password('password')
    password_confirmation('password')
  end

  factory :category do
    name('Benzinaio')
    user_id(1)
    gas_station(true)
  end

  factory :company do
    name('Esso')
    adress('Ravenna')
    number('345')
    category_id(1)
    user_id(1)
  end

  factory :vehicle do
    plate('ER354BS')
    type_of_vehicle('trattore')
    user_id(1)
  end

  factory :fuel_receipt do
    total(300)
    litres(200)
    date_of_issue('01/04/2015')
    company_id(1)
    vehicle_id(1)
    user_id(1)
  end

  factory :invoice do
    reason('Manutenzione')
    total(110)
    total_vat(10)
    user_id(1)
    vehicle_id(1)
    company_id(1)
    at_the_expense_of('Veicolo')
    category_id(1)
    date_of_issue('01/04/2015')
    type_of_invoice('attiva')
    total_taxable(100)
    deadline('01/06/2015')
  end
end
