# frozen_string_literal: true

module Items
  class ItemUnitOfMeasuresController < ApplicationController # :nodoc:
    include SimpleCrudController

    permitted_params :item_id, :unit_of_measure_id, :base_conversion

    def create
      item_unit_of_measure = ItemUnitOfMeasure.new(
        resource_params.merge(item_id: item.id)
      )

      if item_unit_of_measure.save
        redirect_to item, notice: t('.success')
      else
        flash[:alert] = t('.failure')
        render_new(item_unit_of_measure)
      end
    end

    def update
      item_unit_of_measure = existing_resource

      if item_unit_of_measure.update(resource_params)
        redirect_to item_path(item_unit_of_measure.item_id),
                    notice: t('.success')
      else
        flash[:alert] = t('.failure')
        render_edit(item_unit_of_measure)
      end
    end

    private

    def item
      @item ||= Item.find(params[:item_id])
    end

    def render_edit(item_unit_of_measure)
      render :edit,
             locals: {
               item: item_unit_of_measure.item,
               item_unit_of_measure: item_unit_of_measure
             }
    end

    def render_new(item_unit_of_measure)
      render :new,
             locals: {
               item: item,
               item_unit_of_measure: item_unit_of_measure
             }
    end
  end
end
