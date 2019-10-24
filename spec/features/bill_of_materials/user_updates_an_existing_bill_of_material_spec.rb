# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user updates an existing bill of material' do
  given(:current_user) { create(:user, :confirmed) }
  given(:bill_of_material) { create(:bill_of_material) }

  context 'when the user has not signed in' do
    background { visit edit_bill_of_material_path(bill_of_material) }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:new_details) { attributes_for(:bill_of_material) }

    scenario 'they see the bill of materials details have been changed' do
      visit edit_bill_of_material_path(bill_of_material)

      fill_in :bill_of_material_code, with: new_details[:code]

      click_on t('bill_of_materials.columns.save')

      expect(page).to have_content(t('bill_of_materials.update.success'))

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

    scenario 'they see the failure message' do
      visit edit_bill_of_material_path(bill_of_material)

      fill_in :bill_of_material_code, with: nil

      click_on t('bill_of_materials.columns.save')

      expect(page).to have_content(t('bill_of_materials.update.failure'))
    end
  end
end
