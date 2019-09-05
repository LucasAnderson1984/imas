# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item do
  subject { instance }

  let(:instance) { build(:item, :uuid) }

  it { is_expected.to validate_presence_of(:is_active) }
  it { is_expected.to validate_presence_of(:item_description) }
  it { is_expected.to validate_presence_of(:item_number) }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_uniqueness_of(:item_number).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:uuid).case_insensitive }
end
