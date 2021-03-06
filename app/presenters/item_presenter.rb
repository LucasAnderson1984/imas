# frozen_string_literal: true

class ItemPresenter # :nodoc:
  attr_reader :item, :view_context

  delegate :t, to: :view_context
  delegate :bill_of_material,
           :id,
           :is_active,
           :item_description,
           :item_number,
           :unit_of_measure,
           :item_unit_of_measures,
           to: :item
  delegate :code, to: :unit_of_measure, prefix: true
  delegate :code, to: :bill_of_material, prefix: true, allow_nil: true

  def initialize(item, view_context)
    @item = item
    @view_context = view_context
  end

  def status
    return t('presenters.item.active') if @item.active?

    t('presenters.item.inactive')
  end
end
