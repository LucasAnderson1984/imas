# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a item' do
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

    given(:item) { create(:item, :active, :uuid) }

    scenario 'they see the users details' do
      visit item_path(item)

      expect(page).to have_display_field(
        t('items.show.labels.item_number'), item.item_number
      )
      expect(page).to have_display_field(
        t('items.show.labels.item_description'), item.item_description
      )
      expect(page).to have_display_field(
        t('items.show.labels.status'),
        t('presenters.item.active')
      )
    end
  end
end
