# frozen_string_literal: true

module Users
  class UnlocksController < Devise::SessionsController # :nodoc:
    layout 'minimal'
  end
end
