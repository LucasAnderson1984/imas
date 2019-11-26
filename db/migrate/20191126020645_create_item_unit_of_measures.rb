# frozen_string_literal: true

class CreateItemUnitOfMeasures < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :item_unit_of_measures do |t|
      t.references :item
      t.references :unit_of_measure
      t.integer :base_conversion

      t.timestamps
    end
  end
end
