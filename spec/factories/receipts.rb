FactoryGirl.define do
  factory :receipt do
    paid(1100)
    policy_number('12')
    payment_date(Time.zone.now + 3.months)
    method_of_payment('Bonifico')
    insurance_id(1)
  end
end
