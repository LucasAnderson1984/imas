# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a sale' do
  include ActiveSupport::NumberHelper

  given(:user) { create(:user, :confirmed) }

  context 'when the user has not signed in' do
    background do
      visit admin_user_path(user)
    end

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(user.email, user.password)
    end

    given(:sale) { create(:sale) }

    scenario 'they see the sale details' do
      visit sale_path(sale)

      expect(page).to have_display_field(
        t('activerecord.attributes.sales.customer_name'), sale.customer.name
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.items.item_number'), sale.item.item_number
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.items.item_description'),
        sale.item.item_description
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.unit_of_measures.code'),
        sale.unit_of_measure.code
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.sales.sales_date'),
        sale.sales_date.strftime('%m/%d/%Y')
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.sales.sales_quantity'),
        number_to_delimited(sale.sales_quantity, delimiter: ',')
      )
    end
  end
end
