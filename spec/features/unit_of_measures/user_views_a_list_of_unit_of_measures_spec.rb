# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a list of unit of measures' do
  context 'when the user has not signed in' do
    background { visit unit_of_measures_path }

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given!(:unit_of_measures) do
      create_list(:unit_of_measure, 2)
    end

    scenario 'they see a list of unit of measures' do
      visit unit_of_measures_path

      unit_of_measures.each do |unit_of_measure|
        within("tr#unit_of_measure-#{unit_of_measure.id}") do
          expect(page).to have_column_value(
            t('unit_of_measures.index.columns.code'), unit_of_measure.code
          )
        end
      end
    end
  end
end
