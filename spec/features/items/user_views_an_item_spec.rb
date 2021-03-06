# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views an item' do
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

    given(:item) { create(:item) }

    scenario 'they see the item details' do
      visit item_path(item)

      expect(page).to have_display_field(
        t('activerecord.attributes.items.item_number'), item.item_number
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.items.item_description'),
        item.item_description
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.unit_of_measures.code'),
        item.unit_of_measure.code
      )
      expect(page).to have_display_field(
        t('shared.labels.status'),
        t('presenters.item.active')
      )
    end
  end
end
