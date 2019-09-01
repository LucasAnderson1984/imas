# frozen_string_literal: true

module Helpers
  module Features
    module Authentication # :nodoc:
      def sign_in_with(email_address, password)
        visit new_user_session_path

        fill_in t('users.sessions.new.email'), with: email_address
        fill_in t('users.sessions.new.password'), with: password

        click_on t('users.sessions.new.submit')
      end
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::Features::Authentication, type: :feature
end
