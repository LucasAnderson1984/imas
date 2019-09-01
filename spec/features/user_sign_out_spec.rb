# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'user signs out' do
  background do
    sign_in_with(user.email, user.password)
  end

  given(:user) { create(:user, :confirmed) }

  scenario 'they see you sign out successfully' do
    visit root_path

    click_on t('menu.sign_out')

    expect(page).to have_content(t('devise.sessions.signed_out'))
  end
end
