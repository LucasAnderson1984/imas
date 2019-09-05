# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    item_number { Faker::Commerce.material }
    item_description { Faker::Commerce.product_name }

    trait :uuid do
      uuid { SecureRandom.uuid }
    end
  end
end
