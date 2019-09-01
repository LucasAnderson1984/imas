# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'user views the home page' do
  given(:user) { create(:user, :confirmed) }

  background do
    sign_in_with(user.email, user.password)
  end

  scenario 'they see the title' do
    visit root_path

    expect(page).to have_content(t('home.index.title'))
  end

  scenario 'they see a welcome message' do
    visit root_path

    expect(page).to have_content(t('home.index.welcome'))
  end
end
