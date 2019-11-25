# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemPresenter do
  include ActionView::TestCase::Behavior

  let(:instance) { SalePresenter.new(sale, view) }
  let(:sale) { create(:sale) }

  describe '#name_of_date_string' do
    context 'when the date is mm/dd/yyyy' do
      subject { instance.name_of_date_string }

      it { is_expected.to eq sale.sales_date.strftime('%m/%d/%Y') }
    end
  end

  describe '#delimited_sales_quantity' do
    context 'when the sales quantity is delimited' do
      subject { instance.delimited_sales_quantity }

      it do
        is_expected.to eq view.number_with_delimiter(
          sale.sales_quantity,
          delimiter: ','
        )
      end
    end
  end
end
