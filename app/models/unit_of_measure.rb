# frozen_string_literal: true

class UnitOfMeasure < ApplicationRecord # :nodoc:
  include Disableable

  has_many :items

  validates :code,
            :uuid,
            uniqueness: { case_sensitive: false }

  validates :code,
            :uuid,
            presence: true
end
