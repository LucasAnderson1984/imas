# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController # :nodoc:
    layout 'minimal'
  end
end
