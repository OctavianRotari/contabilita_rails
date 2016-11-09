FactoryGirl.define do
  factory :category do
    name('Benzinaio')
    user_id(1)
    gas_station(true)
  end

  factory :insurance_category, class: Category do
    name('Assicurazioni')
    user_id(1)
    gas_station(false)
  end
end
