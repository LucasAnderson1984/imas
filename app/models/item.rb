# frozen_string_literal: true

class Item < ApplicationRecord # :nodoc:
  validates :uuid,
            :item_number,
            uniqueness: { case_sensitive: false }

  validates :uuid,
            :item_number,
            :item_description,
            :is_active,
            presence: true
end
