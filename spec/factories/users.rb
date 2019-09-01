# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    uuid { SecureRandom.uuid }
  end

  trait :confirmed do
    confirmed_at { Time.zone.now }
  end

  trait :inactive do
    is_active { false }
  end
end
