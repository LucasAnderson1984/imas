# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views an unit of measure' do
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

    given(:unit_of_measure) { create(:unit_of_measure) }

    scenario 'they see the unit of measure details' do
      visit unit_of_measure_path(unit_of_measure)

      expect(page).to have_display_field(
        t('activerecord.attributes.unit_of_measures.code'),
        unit_of_measure.code
      )
    end
  end
end
