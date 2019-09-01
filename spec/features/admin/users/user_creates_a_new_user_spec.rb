# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user creates a new user' do
  context 'when the user has not signed in' do
    background { visit new_admin_user_path }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given(:new_details) { attributes_for(:user) }

    scenario 'they see the new users details' do
      visit new_admin_user_path

      fill_in :user_entry_email, with: new_details[:email]
      fill_in :user_entry_name, with: new_details[:name]
      fill_in :user_entry_password, with: new_details[:password]
      check t('simple_form.labels.user_entry.is_active')

      click_on t('admin.users.new.save')

      expect(page).to have_content(t('admin.users.create.success'))

      expect(page).to have_display_field(
        t('admin.users.show.labels.name'), new_details[:name]
      )
      expect(page).to have_display_field(
        t('admin.users.show.labels.email'), new_details[:email]
      )
      expect(page).to have_display_field(
        t('admin.users.index.columns.status'),
        t('presenters.user.active')
      )
    end
  end

  context 'when the details are not valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }

    scenario 'they see the failure message' do
      visit new_admin_user_path

      click_on t('admin.users.new.save')

      expect(page).to have_content(t('admin.users.create.failure'))
    end
  end
end
