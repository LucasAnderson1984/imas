# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a list of sales' do
  include ActiveSupport::NumberHelper

  context 'when the user has not signed in' do
    background { visit sales_path }

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given!(:sales) { create_list(:sale, 2) }

    scenario 'they see a list of sales' do
      visit sales_path

      sales.each do |sale|
        within("tr#sale-#{sale.id}") do
          expect(page).to have_column_value(
            t('activerecord.attributes.sales.customer_name'),
            sale.customer.name
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.items.item_number'),
            sale.item.item_number
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.items.item_description'),
            sale.item.item_description
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.unit_of_measures.code'),
            sale.unit_of_measure.code
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.sales.sales_date'),
            sale.sales_date.strftime('%m/%d/%Y')
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.sales.sales_quantity'),
            number_to_delimited(sale.sales_quantity, delimiter: ',')
          )
        end
      end
    end
  end
end
