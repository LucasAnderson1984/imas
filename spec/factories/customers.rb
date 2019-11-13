# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip_code[0, 5] }
    country { Faker::Address.country_code }
  end
end
