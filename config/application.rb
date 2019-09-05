# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Imas # :nodoc:
  class Application < Rails::Application # :nodoc:
    config.load_defaults 6.0

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
