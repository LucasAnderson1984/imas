# frozen_string_literal: true

class UnitOfMeasure < ApplicationRecord # :nodoc:
  has_many :item_unit_of_measures
  has_many :items
  has_many :sales

  validates :code, uniqueness: { case_sensitive: false }
  validates :code, presence: true
end
