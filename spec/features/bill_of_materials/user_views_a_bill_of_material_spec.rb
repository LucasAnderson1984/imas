# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a bill of material' do
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

    given(:bill_of_material) { create(:bill_of_material) }

    scenario 'they see the bill of material details' do
      visit bill_of_material_path(bill_of_material)

      expect(page).to have_display_field(
        t('activerecord.attributes.bill_of_materials.code'),
        bill_of_material.code
      )
    end
  end
end
