FactoryGirl.define do
  factory :user do
    email "example@example.com"
    password "MyString"
    password_confirmation "MyString"
    role 0

    factory :admin do
      role 1
    end
  end
end
