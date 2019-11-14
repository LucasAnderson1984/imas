# frozen_string_literal: true

class Sale < ApplicationRecord # :nodoc:
  include Disableable

  belongs_to :customer
  belongs_to :item
  belongs_to :unit_of_measure

  validates :customer,
            :item,
            :sales_date,
            :sales_quantity,
            :unit_of_measure,
            presence: true

  validates :sales_quantity,
            numericality: { only_integer: true }
end
