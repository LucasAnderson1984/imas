# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    sequence(:item_number) { |n| "#{Faker::Commerce.material} #{n}" }
    item_description { Faker::Commerce.product_name }

    trait :active do
      is_active { true }
    end

    trait :inactive do
      is_active { false }
    end

    trait :uuid do
      uuid { SecureRandom.uuid }
    end
  end
end
