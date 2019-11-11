# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared_scenarios'

RSpec.feature 'user views a list of customers' do
  context 'when the user has not signed in' do
    background { visit customers_path }

    include_examples 'user must sign in'
  end

  context 'when the user has signed in' do
    background do
      sign_in_with(current_user.email, current_user.password)
    end
    given(:current_user) { create(:user, :confirmed) }
    given!(:customers) do
      create_list(:customer, 2)
    end

    scenario 'they see a list of customers' do
      visit customers_path

      customers.each do |customer|
        within("tr#customer-#{customer.id}") do
          expect(page).to have_column_value(
            t('activerecord.attributes.customers.name'),
            customer.name
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.customers.address'),
            customer.address
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.customers.city'),
            customer.city
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.customers.state'),
            customer.state
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.customers.zip'),
            customer.zip
          )
          expect(page).to have_column_value(
            t('activerecord.attributes.customers.country'),
            customer.country
          )
        end
      end
    end
  end
end
