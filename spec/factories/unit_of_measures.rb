# frozen_string_literal: true

FactoryBot.define do
  factory :unit_of_measure do
    sequence(:code) { |n| "#{Faker::Measurement.height(amount: 'all')} #{n}" }
    uuid { SecureRandom.uuid }
  end
end
