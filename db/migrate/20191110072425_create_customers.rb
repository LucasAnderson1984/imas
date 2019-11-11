# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :customers do |t|
      t.string :name, index: { unique: true }, null: false
      t.string :address
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 5
      t.string :country, limit: 2

      t.timestamps
    end
  end
end
