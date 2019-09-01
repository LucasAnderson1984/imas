# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'user signs in' do
  given(:user) { create(:user, :confirmed) }

  context 'when the details are not valid' do
    scenario 'they see invalid email or password' do
      visit new_user_session_path

      fill_in t('users.sessions.new.email'), with: user.email
      fill_in t('users.sessions.new.password'), with: nil

      click_on t('users.sessions.new.submit')

      expect(page)
        .to have_content(
          t('devise.failure.invalid', authentication_keys: 'Email')
        )
    end
  end

  context 'when the details are valid' do
    scenario 'they see the sign in was successful' do
      visit new_user_session_path

      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password

      click_on t('users.sessions.new.submit')

      expect(page).to have_content(t('devise.sessions.signed_in'))
    end
  end
end
