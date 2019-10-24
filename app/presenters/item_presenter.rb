# frozen_string_literal: true

class ItemPresenter # :nodoc:
  attr_reader :item, :view_context

  delegate :t, to: :view_context
  delegate :bill_of_material_id,
           :id,
           :is_active,
           :item_description,
           :item_number,
           :unit_of_measure,
           :uuid,
           to: :item
  delegate :code, to: :unit_of_measure, prefix: true

  def initialize(item, view_context)
    @item = item
    @view_context = view_context
  end

  def bill_of_material_code
    @item.bill_of_material.code
  end

  def status
    return t('presenters.item.active') if @item.active?

    t('presenters.item.inactive')
  end
end
