# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject { instance }

  let(:instance) { build(:user, :confirmed) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  describe '#to_s' do
    subject { instance.to_s }

    it { is_expected.to eq instance.name }
  end

  describe '#active?' do
    context 'when is_active is equal to 1' do
      subject { instance.active? }

      it { is_expected.to be true }
    end

    context 'when is_active is not equal to 1' do
      subject { instance.active? }

      let(:instance) { build(:user, is_active: 0) }

      it { is_expected.to be false }
    end
  end
end
