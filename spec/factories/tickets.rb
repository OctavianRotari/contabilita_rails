FactoryGirl.define do
  factory :ticket do
    total(90)
    date_of_issue(Time.zone.now)
    description('Giovanni')
    type_of(1)
    vehicle_id(1)
    deadline(Time.zone.now + 2.month)
    user_id(1)
  end

  factory :administrative_ticket, class: Ticket do
    total(90)
    date_of_issue(Time.zone.now)
    description('Multa mancata iva')
    type_of(2)
    vehicle_id(nil)
    deadline(Time.zone.now + 2.month)
    user_id(1)
  end
end
