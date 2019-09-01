# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a list of users' do
  context 'when the user has not signed in' do
    background { visit admin_users_path }

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given!(:users) do
      [current_user] + create_list(:user, 2, :confirmed)
    end

    scenario 'they see a list of users' do
      visit admin_users_path

      users.each do |user|
        within("tr#user-#{user.id}") do
          expect(page).to have_column_value(
            t('admin.users.index.columns.name'), user.name
          )
          expect(page).to have_column_value(
            t('admin.users.index.columns.email'), user.email
          )
          expect(page).to have_column_value(
            t('admin.users.index.columns.status'),
            t('presenters.user.active')
          )
        end
      end
    end
  end
end
