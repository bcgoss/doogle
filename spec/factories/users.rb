FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'password'
    password_confirmation 'password'
    role 0

    factory :admin do
      email 'admin@example.com'
      role 1
    end
  end
end
