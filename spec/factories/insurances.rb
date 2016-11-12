FactoryGirl.define do
  factory :insurance do
    total('1100')
    vehicle_id(1)
    at_the_expense_of('1')
    serial_of_contract('12321')
    company_id(1)
    deadline(Time.zone.now + 1.year)
    date_of_issue(Time.zone.now)
    recurrence(3)
    user_id(1)
  end
end
