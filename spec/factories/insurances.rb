FactoryGirl.define do
  factory :insurance do
    total('1100')
    vehicle_id(1)
    serial_of_contract('12321')
    company_id(1)
    deadline(Time.zone.now)
    date_of_issue(Time.zone.now + 1.month)
    recurrence(3)
  end
end
