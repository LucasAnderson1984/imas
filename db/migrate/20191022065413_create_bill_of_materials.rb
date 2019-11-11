# frozen_string_literal: true

class CreateBillOfMaterials < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :bill_of_materials do |t|
      t.string :code, index: { unique: true }, null: false
      t.timestamps
    end
  end
end
