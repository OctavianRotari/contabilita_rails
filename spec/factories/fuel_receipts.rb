FactoryGirl.define do
  factory :fuel_receipt do
    total(300.22)
    litres(200)
    date_of_issue(Time.zone.now)
    company_id(1)
    vehicle_id(1)
    user_id(1)
  end
end
