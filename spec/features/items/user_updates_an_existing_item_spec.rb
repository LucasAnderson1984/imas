# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user updates an existing item' do
  given(:current_user) { create(:user, :confirmed) }
  given(:item) { create(:item, unit_of_measure_uuid: unit_of_measures[0].uuid) }
  given!(:unit_of_measures) { create_list(:unit_of_measure, 2) }

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
      select unit_of_measures[1].code, from: :item_unit_of_measure_uuid
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
        t('items.show.labels.unit_of_measure'), unit_of_measures[1].code
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
