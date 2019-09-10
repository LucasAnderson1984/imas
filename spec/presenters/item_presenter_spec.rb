# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemPresenter do
  include ActionView::TestCase::Behavior

  let(:instance) { ItemPresenter.new(item, view) }

  describe '#status' do
    context 'when item is active' do
      subject { instance.status }

      let(:item) { create(:item, :active, :uuid) }

      it { is_expected.to eq t('presenters.item.active') }
    end

    context 'when item is inactive' do
      subject { instance.status }

      let(:item) { create(:item, :inactive, :uuid) }

      it { is_expected.to eq t('presenters.item.inactive') }
    end
  end
end
