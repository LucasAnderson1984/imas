# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item do
  subject { instance }

  let(:instance) { build(:item) }

  it { is_expected.to belong_to(:bill_of_material).optional }
  it { is_expected.to belong_to(:unit_of_measure) }
  it { is_expected.to have_many(:item_unit_of_measures) }
  it { is_expected.to have_many(:sales) }
  it { is_expected.to validate_presence_of(:is_active) }
  it { is_expected.to validate_presence_of(:item_description) }
  it { is_expected.to validate_presence_of(:item_number) }
  it { is_expected.to validate_presence_of(:unit_of_measure) }
  it { is_expected.to validate_uniqueness_of(:item_number).case_insensitive }
end
