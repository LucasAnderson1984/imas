# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UnitOfMeasure do
  subject { instance }

  let(:instance) { build(:unit_of_measure) }

  it { is_expected.to have_many(:items) }
  it { is_expected.to have_many(:item_unit_of_measures) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
end
