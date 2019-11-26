# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemUnitOfMeasure do
  subject { instance }

  let(:instance) { build(:item_unit_of_measure) }

  it { is_expected.to belong_to(:item) }
  it { is_expected.to belong_to(:unit_of_measure) }
  it { is_expected.to validate_presence_of(:item) }
  it { is_expected.to validate_presence_of(:unit_of_measure) }
  it { is_expected.to validate_presence_of(:base_conversion) }
  it do
    is_expected
      .to validate_uniqueness_of(:item_id)
      .scoped_to(:unit_of_measure_id)
  end
  it { is_expected.to validate_numericality_of(:base_conversion) }
end
