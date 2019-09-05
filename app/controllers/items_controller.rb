# frozen_string_literal: true

class ItemsController < ApplicationController # :nodoc:
  include SimpleCrudController

  def create
    user_entry = NewItemEntry.new(create_params)

    if user_entry.valid?
      user = Item.new(create_params.merge(uuid: SecureRandom.uuid))
      user.save!

      redirect_to item_path(user), notice: t('.success') and return
    end

    flash[:alert] = t('.failure')

    render_new(user_entry)
  end

  def new
    render_new(NewItemEntry.new)
  end

  private

  def render_new(item_entry)
    render :new, locals: {
      item_entry: item_entry
    }
  end
end
