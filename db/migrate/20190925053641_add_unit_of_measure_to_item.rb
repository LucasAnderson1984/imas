# frozen_string_literal: true

class AddUnitOfMeasureToItem < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    add_reference :items, :unit_of_measure, null: false
  end
end
