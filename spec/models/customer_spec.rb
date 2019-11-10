# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  subject { instance }

  let(:instance) { build(:customer) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:uuid).case_insensitive }
  it { is_expected.to validate_length_of(:state).is_equal_to(2) }
  it { is_expected.to validate_length_of(:country).is_equal_to(2) }
  it { is_expected.to validate_length_of(:zip).is_equal_to(5) }
end
