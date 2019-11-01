# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a list of items' do
  context 'when the user has not signed in' do
    background { visit items_path }

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given!(:items) do
      create_list(:item, 2)
    end

    scenario 'they see a list of items' do
      visit items_path

      items.each do |item|
        within("tr#item-#{item.id}") do
          expect(page).to have_column_value(
            t('activerecord.attributes.items.item_number'), item.item_number
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.items.item_description'),
            item.item_description
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.unit_of_measures.code'),
            item.unit_of_measure.code
          )
          expect(page).to have_column_value(
            t('shared.columns.status'),
            t('presenters.item.active')
          )
        end
      end
    end
  end
end
