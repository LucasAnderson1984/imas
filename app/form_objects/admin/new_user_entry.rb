# frozen_string_literal: true

module Admin # :nodoc:
  class NewUserEntry # :nodoc:
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :email, :is_active, :name, :password

    validates :email,
              :name,
              :password,
              presence: true
  end
end
