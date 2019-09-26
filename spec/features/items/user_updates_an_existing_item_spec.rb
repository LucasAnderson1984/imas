# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user updates an existing item' do
  given(:current_user) { create(:user, :confirmed) }
  given(:item) { create(:item, :uuid) }

  context 'when the user has not signed in' do
    background { visit edit_item_path(item) }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:new_details) { attributes_for(:item) }

    scenario 'they see the items details have been changed' do
      visit edit_item_path(item)

      fill_in :item_item_number, with: new_details[:item_number]
      fill_in :item_item_description, with: new_details[:item_description]
      select new_details[:unit_of_measure], from: :item_unit_of_measure
      uncheck t('simple_form.labels.item.is_active')

      click_on t('items.columns.save')

      expect(page).to have_content(t('items.update.success'))

      expect(page).to have_display_field(
        t('items.show.labels.item_number'), new_details[:item_number]
      )
      expect(page).to have_display_field(
        t('items.show.labels.item_description'), new_details[:item_description]
      )
      expect(page).to have_display_field(
        t('items.show.labels.status'),
        t('presenters.item.inactive')
      )
    end
  end

  context 'when the details are not valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end

    scenario 'they see the failure message' do
      visit edit_item_path(item)

      fill_in :item_item_number, with: nil
      fill_in :item_item_description, with: nil

      click_on t('items.columns.save')

      expect(page).to have_content(t('items.update.failure'))
    end
  end
end
