# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController # :nodoc:
    layout 'minimal'
  end
end
