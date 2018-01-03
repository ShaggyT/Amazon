FactoryBot.define do
  factory :user do
     first_name { Faker::Name.first_name }
     last_name  { Faker::Name.last_name }
     sequence(:email)  {|n| "#{first_name.downcase}-#{n}.#{last_name.downcase}@example.com"}
     password   'password'
     is_admin false
  end

  trait :admin do
     is_admin   true
  end
end
