FactoryGirl.define do
  factory :company do
    name('Esso')
    adress('Ravenna')
    number('345')
    category_id(1)
    user_id(1)
  end

  factory :insurance_company, class: Company do
    name('Milano assicurazioni')
    adress('Ravenna')
    number('345')
    category_id(1)
    user_id(1)
  end
end
