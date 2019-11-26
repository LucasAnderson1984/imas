# frozen_string_literal: true

class ItemUnitOfMeasure < ApplicationRecord # :nodoc:
  include Disableable

  belongs_to :item
  belongs_to :unit_of_measure

  validates :item_id,
            uniqueness: { scope: :unit_of_measure_id }

  validates :item,
            :unit_of_measure,
            :base_conversion,
            presence: true

  validates :base_conversion,
            numericality: { only_integer: true }
end
