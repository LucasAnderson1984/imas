# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :items, id: :uuid do |t|
      t.uuid :uuid, null: false
      t.string :item_number, null: false
      t.string :item_description
      t.integer :is_active, default: 1, null: false
      t.timestamps

      t.index :uuid, unique: true
      t.index :item_number, unique: true
    end
  end
end
