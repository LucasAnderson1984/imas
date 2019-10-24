# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user updates an existing unit of measure' do
  given(:current_user) { create(:user, :confirmed) }
  given(:unit_of_measure) { create(:unit_of_measure) }

  context 'when the user has not signed in' do
    background { visit edit_unit_of_measure_path(unit_of_measure) }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:new_details) { attributes_for(:unit_of_measure) }

    scenario 'they see the unit of measures details have been changed' do
      visit edit_unit_of_measure_path(unit_of_measure)

      fill_in :unit_of_measure_code, with: new_details[:code]

      click_on t('unit_of_measures.columns.save')

      expect(page).to have_content(t('unit_of_measures.update.success'))

      expect(page).to have_display_field(
        t('unit_of_measures.show.labels.code'),
        new_details[:code]
      )
    end
  end

  context 'when the details are not valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end

    scenario 'they see the failure message' do
      visit edit_unit_of_measure_path(unit_of_measure)

      fill_in :unit_of_measure_code, with: nil

      click_on t('unit_of_measures.columns.save')

      expect(page).to have_content(t('unit_of_measures.update.failure'))
    end
  end
end
