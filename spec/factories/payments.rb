FactoryGirl.define do
  factory :payment do
    paid(100)
    method_of_payment('cassa')
    payment_date(Time.zone.now + 1.day)
    invoice_id(1)
  end
end
