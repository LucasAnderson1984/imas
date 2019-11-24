# frozen_string_literal: true

class SalesController < ApplicationController # :nodoc:
  include SimpleCrudController

  private

  def render_show(existing_sale)
    render :show, locals: {
      sale: SalePresenter.new(existing_sale, view_context)
    }
  end

  def resources
    @resources ||= resource_class.all.map do |sale|
      SalePresenter.new(sale, view_context)
    end
  end
end
