# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user creates a new bill of material' do
  context 'when the user has not signed in' do
    background { visit new_bill_of_material_path }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given(:new_details) { attributes_for(:bill_of_material) }

    scenario 'they see the new bill of material details' do
      visit new_bill_of_material_path

      fill_in :bill_of_material_code,
              with: new_details[:code]

      click_on t('bill_of_materials.columns.save')

      expect(page).to have_content(t('bill_of_materials.create.success'))

      expect(page).to have_display_field(
        t('bill_of_materials.show.labels.code'),
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
      visit new_bill_of_material_path

      click_on t('bill_of_materials.columns.save')

      expect(page).to have_content(t('bill_of_materials.create.failure'))
    end
  end
end
