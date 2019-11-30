# frozen_string_literal: true

require 'rails_helper'
require_relative '../../shared_scenarios'

RSpec.feature 'user views a list of an item\'s unit of measures' do
  given(:item) { create(:item) }

  context 'when the user has not signed in' do
    background { visit item_path(item.id) }

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given!(:item_unit_of_measures) do
      create_list(:item_unit_of_measure, 2, item: item)
    end

    scenario 'they see a list of item\'s unit of measures' do
      visit item_path(item.id)

      item_unit_of_measures.each do |item_unit_of_measure|
        within("tr#item_unit_of_measure-#{item_unit_of_measure.id}") do
          expect(page).to have_column_value(
            t('activerecord.attributes.unit_of_measures.code'),
            item_unit_of_measure.unit_of_measure.code
          )
          expect(page).to have_column_value(
            t(
              'activerecord' \
              '.attributes' \
              '.items' \
              '.item_unit_of_measures' \
              '.base_conversion'
            ),
            item_unit_of_measure.base_conversion
          )
        end
      end
    end
  end
end
