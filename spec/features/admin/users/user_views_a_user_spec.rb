# frozen_string_literal: true

require 'rails_helper'
require_relative '../../shared_scenarios'

RSpec.feature 'user views a user' do
  given(:user) { create(:user, :confirmed) }

  context 'when the user has not signed in' do
    background do
      visit admin_user_path(user)
    end

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(user.email, user.password)
    end

    scenario 'they see the users details' do
      visit admin_user_path(user)

      expect(page).to have_display_field(
        t('activerecord.attributes.admin.users.name'), user.name
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.admin.users.email'), user.email
      )
      expect(page).to have_display_field(
        t('shared.labels.status'),
        t('presenters.user.active')
      )
    end
  end
end
