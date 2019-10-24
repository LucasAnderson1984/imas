# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a list of bill of materials' do
  context 'when the user has not signed in' do
    background { visit bill_of_materials_path }

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given!(:bill_of_materials) do
      create_list(:bill_of_material, 2)
    end

    scenario 'they see a list of bill of materials' do
      visit bill_of_materials_path

      bill_of_materials.each do |bill_of_material|
        within("tr#bill_of_material-#{bill_of_material.id}") do
          expect(page).to have_column_value(
            t('bill_of_materials.index.columns.code'), bill_of_material.code
          )
        end
      end
    end
  end
end
