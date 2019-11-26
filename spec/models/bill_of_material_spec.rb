# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillOfMaterial do
  subject { instance }

  let(:instance) { build(:bill_of_material) }

  it { is_expected.to have_one(:item) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
end
