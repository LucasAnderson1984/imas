# frozen_string_literal: true

class Customer < ApplicationRecord # :nodoc:
  include Disableable

  validates :name,
            :uuid,
            uniqueness: { case_sensitive: false }

  validates :name,
            :uuid,
            presence: true

  validates :state,
            :country,
            length: { is: 2 }

  validates :zip,
            length: { is: 5 }
end
