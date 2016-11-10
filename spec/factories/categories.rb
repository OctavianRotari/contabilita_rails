FactoryGirl.define do
  factory :category do
    name('Meccanici')
    user_id(1)
    type_of('Altro')
  end

  factory :insurance_category, class: Category do
    name('Assicurazioni')
    user_id(1)
    type_of('Assicurazioni')
  end

  factory :gas_station_category, class: Category do
    name('Benzinaii')
    user_id(1)
    type_of('Benzinaii')
  end
end
