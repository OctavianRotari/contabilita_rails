FactoryGirl.define do
  factory :invoice do
    reason('Manutenzione')
    total(110)
    total_vat(10)
    user_id(1)
    vehicle_id(1)
    company_id(1)
    at_the_expense_of(1)
    serial_number('1223')
    category_id(1)
    date_of_issue(Time.zone.now)
    type_of_invoice('attiva')
    total_taxable(100)
    deadline(Time.zone.now + 1.month)
    paid(false)
  end

  factory :passive_invoice, class: Invoice do
    reason('Manutenzione')
    total(110)
    total_vat(10)
    user_id(1)
    vehicle_id(1)
    company_id(1)
    at_the_expense_of(1)
    serial_number('1223')
    category_id(1)
    date_of_issue(Time.zone.now)
    type_of_invoice('passiva')
    total_taxable(100)
    deadline(Time.zone.now + 1.month)
    paid(false)
  end

  factory :general_expenses_invoice, class: Invoice do
    reason('Manutenzione')
    total(110)
    total_vat(10)
    user_id(1)
    vehicle_id(nil)
    company_id(1)
    serial_number('1223')
    at_the_expense_of('general_expenses')
    category_id(1)
    date_of_issue(Time.zone.now)
    type_of_invoice('passiva')
    total_taxable(100)
    deadline(Time.zone.now + 1.month)
    paid(false)
  end

  factory :invoice_params_general_expenses, class: Invoice do
    taxable_vat_fields_attributes({"1"=>{taxable: "100", vat_rate: "10", "_destroy"=>"false"}})
    reason('Manutenzione')
    user_id(1)
    at_the_expense_of('general_expences')
    serial_number('1223')
    company_id('1')
    date_of_issue(Time.zone.now)
    type_of_invoice('attiva')
    deadline(Time.zone.now + 1.month)
    paid(false)
  end

  factory :invoice_params_vehicle, class: Invoice do
    taxable_vat_fields_attributes({"1"=>{taxable: "100", vat_rate: "10", "_destroy"=>"false"}})
    reason('Manutenzione')
    user_id(1)
    serial_number('1223')
    at_the_expense_of('specific_vehicle')
    vehicle_id('1')
    company_id('1')
    date_of_issue(Time.zone.now)
    type_of_invoice('attiva')
    deadline(Time.zone.now + 1.month)
    paid(false)
  end
end
