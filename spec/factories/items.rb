# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    bill_of_material
    sequence(:item_number) { |n| "#{Faker::Commerce.material} #{n}" }
    item_description { Faker::Commerce.product_name }
    is_active { true }
    unit_of_measure
    uuid { SecureRandom.uuid }

    trait :inactive do
      is_active { false }
    end
  end
end
