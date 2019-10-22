# frozen_string_literal: true

class Item < ApplicationRecord # :nodoc:
  include Disableable

  belongs_to :unit_of_measure,
             primary_key: :uuid,
             foreign_key: :unit_of_measure_uuid

  validates :item_number,
            :uuid,
            uniqueness: { case_sensitive: false }

  validates :is_active,
            :item_description,
            :item_number,
            :unit_of_measure_uuid,
            :uuid,
            presence: true
end
