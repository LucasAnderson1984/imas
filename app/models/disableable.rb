# frozen_string_literal: true

module Disableable # :nodoc:
  def active?
    is_active == 1
  end
end
