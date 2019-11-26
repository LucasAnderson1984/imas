# frozen_string_literal: true

class Item < ApplicationRecord # :nodoc:
  include Disableable

  belongs_to :unit_of_measure
  belongs_to :bill_of_material, optional: true

  validates :item_number, uniqueness: { case_sensitive: false }
  validates :is_active,
            :item_description,
            :item_number,
            :unit_of_measure,
            presence: true

  def full_item_description
    [item_number, '-', item_description].join(' ')
  end
end
