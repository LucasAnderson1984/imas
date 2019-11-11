# frozen_string_literal: true

FactoryBot.define do
  factory :bill_of_material do
    code { Faker::Code.sin }
  end
end
