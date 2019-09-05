# frozen_string_literal: true

class NewItemEntry # :nodoc:
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :item_number, :item_description

  validates :item_number,
            :item_description,
            presence: true
end
