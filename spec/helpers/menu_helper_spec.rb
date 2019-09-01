# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenuHelper do
  describe '#menu' do
    subject { helper.menu }
    before do
      allow(helper)
        .to receive(:current_user)
        .and_return(user)
      allow(helper)
        .to receive(:user_signed_in?)
        .and_return(signed_in)
    end

    context 'when a user is not signed in' do
      let(:signed_in) { false }
      let(:user) { nil }

      it { is_expected.to have_content t('menu.sign_in') }
    end

    context 'when a user is signed in' do
      let(:signed_in) { true }
      let(:user) { build_stubbed(:user) }

      it { is_expected.to have_content t('menu.sign_out') }
      it { is_expected.to have_content user.name }
    end
  end
end

RSpec.describe MenuHelper::Menu do
  let(:instance) do
    described_class.new(helper)
  end

  describe '#item' do
    subject { instance.item(name, path, {}) }

    let(:name) { 'Users' }
    let(:path) { '/admin/users' }

    it 'renders a menu item' do
      expect(subject).to eq(
        '<li class="nav-item">' \
          '<a class="nav-link" href="/admin/users">Users</a>' \
        '</li>'
      )
    end
  end

  describe '#separator' do
    subject { instance.separator }

    it 'renders a dropdown divider' do
      expect(subject).to eq('<div class="dropdown-divider"></div>')
    end
  end
end
