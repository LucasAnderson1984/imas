# frozen_string_literal: true

class Item < ApplicationRecord # :nodoc:
  include Disableable

  validates :item_number,
            :uuid,
            uniqueness: { case_sensitive: false }

  validates :is_active,
            :item_description,
            :item_number,
            :uuid,
            presence: true
end
