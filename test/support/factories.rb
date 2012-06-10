require 'support/fakes'

FactoryGirl.define do
  factory :page do
    sequence(:title) { |n| "Page title #{n}" }
    body sentence
  end

  factory :user do
    sequence(:first_name) { |n| "John #{n}" }
    sequence(:last_name) { |n| "Smith" }
    sequence(:email) { |n| "john#{n}@example.com"}

    factory :admin_user do
      sequence(:email) { |n| "admin#{n}@example.com"}
      admin true
    end
  end
end
