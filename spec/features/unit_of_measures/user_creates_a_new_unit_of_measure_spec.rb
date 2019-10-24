# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user creates a new unit of measure' do
  context 'when the user has not signed in' do
    background { visit new_unit_of_measure_path }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given(:new_details) { attributes_for(:unit_of_measure) }

    scenario 'they see the new unit of measure details' do
      visit new_unit_of_measure_path

      fill_in :unit_of_measure_code,
              with: new_details[:code]

      click_on t('unit_of_measures.columns.save')

      expect(page).to have_content(t('unit_of_measures.create.success'))

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
    given(:current_user) { create(:user, :confirmed) }

    scenario 'they see the failure message' do
      visit new_unit_of_measure_path

      click_on t('unit_of_measures.columns.save')

      expect(page).to have_content(t('unit_of_measures.create.failure'))
    end
  end
end
