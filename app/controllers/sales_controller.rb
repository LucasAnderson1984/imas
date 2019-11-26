# frozen_string_literal: true

class SalesController < ApplicationController # :nodoc:
  include SimpleCrudController

  private

  def render_show(sale)
    render :show, locals: {
      sale: SalePresenter.new(sale, view_context)
    }
  end

  def resources
    @resources ||= resource_class.all.map do |sale|
      SalePresenter.new(sale, view_context)
    end
  end
end
