FactoryGirl.define do
  factory :vehicle do
    plate('ER354BS')
    type_of_vehicle('trattore')
    user_id(1)
    charge_general_expences(false)
  end
end
