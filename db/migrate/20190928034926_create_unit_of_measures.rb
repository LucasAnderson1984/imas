# frozen_string_literal: true

class CreateUnitOfMeasures < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :unit_of_measures do |t|
      t.string :code, index: { unique: true }, null: false
      t.timestamps
    end
  end
end
