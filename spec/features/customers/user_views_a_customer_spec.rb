# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a customer' do
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

    given(:customer) { create(:customer) }

    scenario 'they see the customer details' do
      visit customer_path(customer)

      expect(page).to have_display_field(
        t('activerecord.attributes.customers.name'),
        customer.name
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.address'),
        customer.address
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.city'),
        customer.city
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.state'),
        customer.state
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.zip'),
        customer.zip
      )
      expect(page).to have_display_field(
        t('activerecord.attributes.customers.country'),
        customer.country
      )
    end
  end
end
