# frozen_string_literal: true

class AddUnitOfMeasureToItem < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    add_column :items,
               :unit_of_measure,
               :string,
               null: false
  end
end
