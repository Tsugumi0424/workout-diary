FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.first_name }
    email                 { 'sample@test.com' }
    password              { '00000012' }
    password_confirmation { password }
  end
end
