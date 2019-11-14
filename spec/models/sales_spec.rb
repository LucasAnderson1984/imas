# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item do
  subject { instance }

  let(:instance) { build(:sale) }

  it { is_expected.to validate_presence_of(:customer) }
  it { is_expected.to validate_presence_of(:item) }
  it { is_expected.to validate_presence_of(:sales_date) }
  it { is_expected.to validate_presence_of(:sales_quantity) }
  it { is_expected.to validate_presence_of(:unit_of_measure) }
  it { is_expected.to validate_numericality_of(:sales_quantity) }
end
