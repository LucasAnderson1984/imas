# frozen_string_literal: true

class BillOfMaterial < ApplicationRecord # :nodoc:
  has_one :item

  validates :code, uniqueness: { case_sensitive: false }
  validates :code, presence: true
end
