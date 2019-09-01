# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPresenter do
  include ActionView::TestCase::Behavior

  let(:instance) { UserPresenter.new(user, view) }

  describe '#status' do
    context 'when user is active' do
      subject { instance.status }

      let(:user) { create(:user, :confirmed) }

      it { is_expected.to eq t('presenters.user.active') }
    end

    context 'when user is inactive' do
      subject { instance.status }

      let(:user) { create(:user, :confirmed, :inactive) }

      it { is_expected.to eq t('presenters.user.inactive') }
    end
  end
end
