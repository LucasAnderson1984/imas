# frozen_string_literal: true

class Item < ApplicationRecord # :nodoc:
  include Disableable

  belongs_to :bill_of_material, optional: true
  belongs_to :unit_of_measure

  has_many :item_unit_of_measures

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
