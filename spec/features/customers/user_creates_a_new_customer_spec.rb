# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user creates a new customer' do
  context 'when the user has not signed in' do
    background { visit new_customer_path }

    include_examples 'user must sign in'
  end

  context 'when the details are valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given(:new_details) { attributes_for(:customer) }

    scenario 'they see the new customer details' do
      visit new_customer_path

      fill_in :customer_name, with: new_details[:name]
      fill_in :customer_address, with: new_details[:address]
      fill_in :customer_city, with: new_details[:city]
      fill_in :customer_state, with: new_details[:state]
      fill_in :customer_zip, with: new_details[:zip]
      fill_in :customer_country, with: new_details[:country]

      click_on t('shared.columns.save')

      expect(page).to have_content(t('customers.create.success'))

      expect(page).to have_display_field(
        t('activerecord.attributes.customers.name'),
        new_details[:name]
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.address'),
        new_details[:address]
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.city'),
        new_details[:city]
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.state'),
        new_details[:state]
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.zip'),
        new_details[:zip]
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.country'),
        new_details[:country]
      )
    end
  end

  context 'when the details are not valid' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }

    scenario 'they see the failure message' do
      visit new_customer_path

      click_on t('shared.columns.save')

      expect(page).to have_content(t('customers.create.failure'))
    end
  end
end
