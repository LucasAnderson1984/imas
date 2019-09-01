# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController # :nodoc:
    layout 'minimal'
  end
end
