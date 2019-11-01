# frozen_string_literal: true

require 'rails_helper'
require_relative '../../shared_scenarios'

RSpec.feature 'user updates an existing user' do
  given(:current_user) { create(:user, :confirmed) }

  context 'when the user has not signed in' do
    background { visit edit_admin_user_path(current_user) }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:new_details) { attributes_for(:user) }

    scenario 'they see the users details have been changed' do
      visit edit_admin_user_path(current_user)

      fill_in :user_entry_email, with: new_details[:email]
      fill_in :user_entry_name, with: new_details[:name]
      uncheck t('simple_form.labels.user_entry.is_active')

      click_on t('shared.buttons.update')

      expect(page).to have_content(t('admin.users.update.success'))

      expect(page).to have_display_field(
        t('activerecord.attributes.admin.users.name'), new_details[:name]
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.admin.users.email'), new_details[:email]
      )
      expect(page).to have_display_field(
        t('shared.labels.status'),
        t('presenters.user.inactive')
      )
    end
  end

  context 'when the details are not valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end

    scenario 'they see the failure message' do
      visit edit_admin_user_path(current_user)

      fill_in :user_entry_email, with: nil
      fill_in :user_entry_name, with: nil

      click_on t('shared.buttons.update')

      expect(page).to have_content(t('admin.users.update.failure'))
    end
  end
end
