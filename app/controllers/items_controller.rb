# frozen_string_literal: true

class ItemsController < ApplicationController # :nodoc:
  include SimpleCrudController

  permitted_params :is_active,
                   :item_description,
                   :item_number,
                   :unit_of_measure_uuid

  private

  def render_show(existing_item)
    render :show, locals: {
      item: ItemPresenter.new(existing_item, view_context)
    }
  end

  def resources
    @resources ||= resource_class.all.map do |item|
      ItemPresenter.new(item, view_context)
    end
  end
end
