# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user updates an existing sale' do
  include ActiveSupport::NumberHelper

  given(:current_user) { create(:user, :confirmed) }
  given!(:customer) { create(:customer) }
  given!(:item) { create(:item) }
  given!(:sale) { create(:sale) }
  given!(:unit_of_measure) { create(:unit_of_measure) }

  context 'when the user has not signed in' do
    background { visit edit_sale_path(sale) }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:new_details) { attributes_for(:sale) }

    scenario 'they see the sales details have been changed' do
      visit edit_sale_path(sale)

      select item.full_item_description, from: :sale_item_id
      select customer.name, from: :sale_customer_id
      select unit_of_measure.code, from: :sale_unit_of_measure_id
      fill_in :sale_sales_date, with: new_details[:sales_date]
      fill_in :sale_sales_quantity, with: new_details[:sales_quantity]

      click_on t('shared.buttons.save')

      expect(page).to have_content(t('sales.update.success'))

      expect(page).to have_display_field(
        t('activerecord.attributes.sales.customer_name'),
        customer.name
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.items.item_number'),
        item.item_number
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.items.item_description'),
        item.item_description
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.unit_of_measures.code'),
        unit_of_measure.code
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.sales.sales_date'),
        new_details[:sales_date].strftime('%m/%d/%Y')
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.sales.sales_quantity'),
        number_to_delimited(
          new_details[:sales_quantity],
          delimiter: ','
        )
      )
    end
  end

  context 'when the details are not valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end

    scenario 'they see the failure message' do
      visit edit_sale_path(sale)

      fill_in :sale_sales_date, with: nil
      fill_in :sale_sales_quantity, with: nil

      click_on t('shared.buttons.save')

      expect(page).to have_content(t('sales.update.failure'))
    end
  end
end
