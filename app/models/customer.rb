# frozen_string_literal: true

class Customer < ApplicationRecord # :nodoc:
  include Disableable

  validates :name, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :state, :country, length: { is: 2 }
  validates :zip, length: { is: 5 }
end
