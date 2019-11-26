# frozen_string_literal: true

FactoryBot.define do
  factory :item_unit_of_measure do
    item
    unit_of_measure
    base_conversion { Faker::Number.number(digits: 5) }
  end
end
