# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user creates a new item' do
  context 'when the user has not signed in' do
    background { visit new_item_path }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given!(:bill_of_material) { create(:bill_of_material) }
    given(:current_user) { create(:user, :confirmed) }
    given(:new_details) { attributes_for(:item) }
    given!(:unit_of_measure) { create(:unit_of_measure) }

    scenario 'they see the new item details' do
      visit new_item_path

      fill_in :item_item_number, with: new_details[:item_number]
      fill_in :item_item_description, with: new_details[:item_description]
      select unit_of_measure.code, from: :item_unit_of_measure_id
      select bill_of_material.code, from: :item_bill_of_material_id
      check t('simple_form.labels.item.is_active')

      click_on t('shared.buttons.save')

      expect(page).to have_content(t('items.create.success'))

      expect(page).to have_display_field(
        t('activerecord.attributes.items.item_number'),
        new_details[:item_number]
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.items.item_description'),
        new_details[:item_description]
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.unit_of_measures.code'),
        unit_of_measure.code
      )
      expect(page).to have_display_field(
        t('shared.columns.status'),
        t('presenters.item.active')
      )
    end
  end

  context 'when the details are not valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }

    scenario 'they see the failure message' do
      visit new_item_path

      click_on t('shared.buttons.save')

      expect(page).to have_content(t('items.create.failure'))
    end
  end
end
