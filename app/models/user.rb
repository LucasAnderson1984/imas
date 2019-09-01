# frozen_string_literal: true

class User < ApplicationRecord # :nodoc:
  include Disableable

  devise :confirmable,
         :database_authenticatable,
         :invitable,
         :lockable,
         :recoverable,
         :rememberable,
         :trackable

  validates :name,
            :email,
            :uuid,
            presence: true

  validates :email,
            :uuid,
            uniqueness: { case_sensitive: false }

  def after_password_reset; end

  def to_s
    name
  end
end
