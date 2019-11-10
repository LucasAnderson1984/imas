# frozen_string_literal: true

class CustomersController < ApplicationController # :nodoc:
  include SimpleCrudController

  permitted_params :name, :address, :city, :state, :zip, :country
end
