# frozen_string_literal: true

module Admin # :nodoc:
  class EditUserEntry # :nodoc:
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :email, :is_active, :name

    validates :email, :name, presence: true
  end
end
