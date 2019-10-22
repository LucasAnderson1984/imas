# frozen_string_literal: true

class UnitOfMeasuresController < ApplicationController # :nodoc:
  include SimpleCrudController

  permitted_params :code
end
