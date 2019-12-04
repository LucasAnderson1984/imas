# frozen_string_literal: true

require 'rails_helper'
require_relative '../../shared_scenarios'

RSpec.feature 'user updates an existing item unit of measure' do
  given(:current_user) { create(:user, :confirmed) }
  given!(:item_unit_of_measure) { create(:item_unit_of_measure) }
  given!(:unit_of_measure) { create(:unit_of_measure) }

  context 'when the user has not signed in' do
    background do
      visit edit_item_item_unit_of_measure_path(
        item_unit_of_measure.item_id,
        item_unit_of_measure.id
      )
    end

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given!(:item) { create(:item) }
    given(:new_details) { attributes_for(:item_unit_of_measure) }

    scenario 'they see the items details have been changed' do
      visit edit_item_item_unit_of_measure_path(
        item_unit_of_measure.item_id,
        item_unit_of_measure.id
      )

      select unit_of_measure.code,
             from: :item_unit_of_measure_unit_of_measure_id
      fill_in :item_unit_of_measure_base_conversion,
              with: new_details[:base_conversion]

      click_on t('shared.buttons.save')

      expect(page).to have_content(
        t('items.item_unit_of_measures.update.success')
      )

      within("tr#item_unit_of_measure-#{item_unit_of_measure.id}") do
        expect(page).to have_column_value(
          t('activerecord.attributes.unit_of_measures.code'),
          unit_of_measure.code
        )
        expect(page).to have_column_value(
          t(
            'activerecord' \
            '.attributes' \
            '.items' \
            '.item_unit_of_measures' \
            '.base_conversion'
          ),
          new_details[:base_conversion]
        )
      end
    end
  end

  context 'when the details are not valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end

    scenario 'they see the failure message' do
      visit edit_item_item_unit_of_measure_path(
        item_unit_of_measure.item_id,
        item_unit_of_measure.id
      )

      fill_in :item_unit_of_measure_base_conversion, with: nil

      click_on t('shared.buttons.save')

      expect(page).to have_content(
        t('items.item_unit_of_measures.update.failure')
      )
    end
  end
end
