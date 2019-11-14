# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :sales do |t|
      t.references :customer
      t.references :item
      t.references :unit_of_measure
      t.date :sales_date
      t.integer :sales_quantity

      t.timestamps
    end
  end
end
