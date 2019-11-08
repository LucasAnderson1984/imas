# frozen_string_literal: true

class BillOfMaterialsController < ApplicationController # :nodoc:
  include SimpleCrudController

  permitted_params :code
end
