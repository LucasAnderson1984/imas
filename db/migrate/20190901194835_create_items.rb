# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :items do |t|
      t.string :item_number, index: { unique: true }, null: false
      t.string :item_description
      t.integer :is_active, default: 1, null: false
      t.timestamps
    end
  end
end
