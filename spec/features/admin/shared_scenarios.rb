# frozen_string_literal: true

RSpec.shared_examples 'user must sign in' do
  scenario 'they see the sign in screen' do
    expect(page).to have_content(t('devise.failure.unauthenticated'))
  end
end
