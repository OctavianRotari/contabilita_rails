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
    date_of_issue(Time.zone.now)
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
    date_of_issue(Time.zone.now)
    type_of_invoice('attiva')
    total_taxable(100)
    deadline(Time.zone.now + 1.month)
    paid(false)
  end

  factory :invoice_params, class: Invoice do
    taxable_vat_fields_attributes({"1"=>{"taxable"=>"100", "vat_rate"=>"10", "_destroy"=>"false"}})
    reason('Manutenzione')
    user_id(1)
    vehicle_id(1)
    company_id(1)
    at_the_expense_of('Veicolo')
    category_id(1)
    date_of_issue(Time.zone.now)
    type_of_invoice('attiva')
    deadline(Time.zone.now + 1.month)
    paid(false)
  end

  factory :payment do
    paid(100)
    method_of_payment('cassa')
    payment_date(Time.zone.now + 1.day)
    invoice_id(1)
  end
end