# frozen_string_literal: true

FactoryBot.define do
  factory :sale do
    customer
    item
    unit_of_measure
    sales_date { Faker::Date.in_date_period }
    sales_quantity { Faker::Number.number(digits: 5) }
  end
end
