# frozen_string_literal: true

class UnitOfMeasure < ApplicationRecord # :nodoc:
  include Disableable

  has_many :items

  validates :code, uniqueness: { case_sensitive: false }
  validates :code, presence: true
end
