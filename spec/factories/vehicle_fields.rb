FactoryGirl.define do
  factory :vehicle_field do
    vehicle_id(1)
    part_of_total('300')
    invoice_id(1)
    created_at(Time.zone.now)
  end
end
