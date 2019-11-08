# frozen_string_literal: true

class AddBillOfMaterialToItem < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    add_reference :items, :bill_of_material
  end
end
