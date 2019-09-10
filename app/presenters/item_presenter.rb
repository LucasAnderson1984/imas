# frozen_string_literal: true

class ItemPresenter # :nodoc:
  attr_reader :item, :view_context

  delegate :t, to: :view_context
  delegate :id,
           :is_active,
           :item_description,
           :item_number,
           :uuid,
           to: :item

  def initialize(item, view_context)
    @item = item
    @view_context = view_context
  end

  def status
    return t('presenters.item.active') if @item.active?

    t('presenters.item.inactive')
  end
end
